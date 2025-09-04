import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce_app/controller/cart_controller.dart';
import 'package:mini_ecommerce_app/screens/cart_screen/widgets/cart_grid.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart'), centerTitle: true),
      body: const CartBody(),
      bottomNavigationBar: const CartSummaryBar(),
    );
  }
}

class CartBody extends GetView<CartController> {
  const CartBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.items.isEmpty) {
        return const _EmptyCart();
      }
      return CartGrid(items: controller.items);
    });
  }
}

//if cart is empty
class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text('Your cart is empty', style: theme.textTheme.titleMedium),
      ),
    );
  }
}

//bottom navigation bar to show the total value of  cart
class CartSummaryBar extends GetView<CartController> {
  const CartSummaryBar({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(top: BorderSide(color: theme.dividerColor)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Items: ${controller.itemCount}',
              style: theme.textTheme.bodyLarge,
            ),
            Text(
              'Total: \$${controller.total.toStringAsFixed(2)}',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    });
  }
}
