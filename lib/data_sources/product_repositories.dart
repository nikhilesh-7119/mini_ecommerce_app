import 'package:mini_ecommerce_app/data_sources/remote_source.dart';

import '../models/product.dart';

class ProductRepository {
  final RemoteSource remoteSource;
  ProductRepository({required this.remoteSource});

  // Network-first, cache fallback
  Future<(List<Product> items, bool fromCache)> getProducts() async {
    try {
      final items = await remoteSource.fetchProducts();
      await remoteSource.saveProductsHive(items);
      return (items, false);
    } catch (_) {
      try {
        final cached = await remoteSource.readProductsHive();
        return (cached, true);
      } catch (e) {
        rethrow;
      }
    }
  }
}
