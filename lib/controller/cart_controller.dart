import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_ecommerce_app/models/cart_item.dart';
import 'package:mini_ecommerce_app/models/product.dart';

class CartController extends GetxController {
  static const _boxName = 'cartBox';
  static const _keyItems = 'items';

  final items = <CartItem>[].obs;

  Set<int> get cartIds => items.map((e) => e.id).toSet();

  int get itemCount => items.fold(0, (acc, e) => acc + e.quantity);

  double get total => items.fold(0.0, (acc, e) => acc + e.lineTotal);

  @override
  void onInit() {
    super.onInit();
    _loadFromHive();
  }

  Future<void> _persist() async {
    final box = Hive.box(_boxName);
    final data = items.map((e) => e.toJson()).toList();
    await box.put(_keyItems, data);
  }

  Future<void> _loadFromHive() async {
    final box = Hive.box(_boxName);
    final data = box.get(_keyItems);
    if (data is List) {
      final loaded = data
          .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
      items.assignAll(loaded);
    }
  }

  void addProduct(Product p) {
    final idx = items.indexWhere((e) => e.id == p.id);
    if (idx == -1) {
      items.add(CartItem(
        id: p.id,
        title: p.title,
        price: p.price,
        image: p.image,
        description: p.description,
        category: p.category,
        rate: p.rating.rate,
        count: p.rating.count,
        quantity: 1,
      ));
    } else {
      increment(p.id);
      return;
    }
    _persist();
  }

  void removeById(int id) {
    items.removeWhere((e) => e.id == id);
    _persist();
  }

  void increment(int id) {
    final idx = items.indexWhere((e) => e.id == id);
    if (idx == -1) return;
    final current = items[idx];
    if (current.quantity >= 10) return;
    items[idx] = current.copyWith(quantity: current.quantity + 1);
    // reassign list to ensure Hive/listeners notice changes in some scenarios
    items.refresh();
    _persist();
  }

  void decrement(int id) {
    final idx = items.indexWhere((e) => e.id == id);
    if (idx == -1) return;
    final current = items[idx];
    final nextQty = current.quantity - 1;
    if (nextQty <= 0) {
      items.removeAt(idx);
    } else {
      items[idx] = current.copyWith(quantity: nextQty);
    }
    items.refresh();
    _persist();
  }

  bool isInCart(int id) => items.any((e) => e.id == id);
}
