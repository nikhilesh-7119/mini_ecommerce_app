import 'package:get/get.dart';
import 'package:mini_ecommerce_app/data_sources/product_repositories.dart';
import 'package:mini_ecommerce_app/data_sources/remote_source.dart';
import 'package:mini_ecommerce_app/models/product.dart';

class HomeController extends GetxController {
  final ProductRepository productRepository;
  HomeController({required this.productRepository});

  final isLoading = false.obs;
  final errorMessage = RxnString();
  final products = <Product>[].obs;
  final fromCache = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  //function to load the products and return error message if no items
  //is present in the hive and internet is not working
  Future<void> loadProducts({bool force = false}) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final (items, cached) = await productRepository.getProducts();
      products.assignAll(items);
      fromCache.value = cached;
    } on NoCacheException {
      errorMessage.value =
          'No internet and no saved data. Connect to the internet and refresh.';
    } catch (e) {
      errorMessage.value =
          'Something went wrong. Connect to the internet and refresh.';
    } finally {
      isLoading.value = false;
    }
  }
}
