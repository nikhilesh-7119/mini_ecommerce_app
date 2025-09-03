import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import '../models/product.dart';

class NoCacheException implements Exception {
  final String message;
  NoCacheException(this.message);
}

class RemoteSource {
  static const String _baseUrl = 'https://fakestoreapi.com';
  static const String _productsPath = '/products';
  static const String _boxName = 'productsBox';
  static const String _keyProducts = 'products';

  // 1) Network: fetch from API
  Future<List<Product>> fetchProducts() async {
    final uri = Uri.parse('$_baseUrl$_productsPath');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(res.body) as List<dynamic>;
      return jsonList.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('HTTP ${res.statusCode}');
    }
  }

  // 2) Save to Hive (replace old)
  Future<void> saveProductsHive(List<Product> items) async {
    final box = Hive.box(_boxName);
    final List<Map<String, dynamic>> serialized = items.map((e) => e.toJson()).toList();
    await box.put(_keyProducts, serialized);
  }

  // 3) Read from Hive
  Future<List<Product>> readProductsHive() async {
    final box = Hive.box(_boxName);
    final data = box.get(_keyProducts);
    if (data == null) throw NoCacheException('No cached data');
    final List list = data as List;
    return list.map((e) => Product.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }
}
