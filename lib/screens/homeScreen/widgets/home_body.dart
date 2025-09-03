import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce_app/controller/home_controller.dart';
import 'home_loading.dart';
import 'home_error.dart';
import 'product_grid.dart';

class HomeBody extends GetView<HomeController> {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const HomeLoading();
      }
      if (controller.errorMessage.value != null) {
        return HomeError(message: controller.errorMessage.value!);
      }
      return ProductGrid(products: controller.products);
    });
  }
}
