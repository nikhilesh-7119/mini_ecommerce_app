import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce_app/controller/home_controller.dart';
import 'package:mini_ecommerce_app/screens/cart_screen/cart_screen.dart';
import 'home_body.dart';

class HomeScaffold extends GetView<HomeController> {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Retry',
            onPressed: () => controller.loadProducts(force: true),
          ),
        ],
      ),
      body: const HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(CartScreen());
        },
        child: Icon(Icons.shopping_cart,size: 32,),
      ),
    );
  }
}
