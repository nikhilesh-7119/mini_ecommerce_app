import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce_app/models/cart_item.dart';
import 'cart_tile.dart';

//gridview builder to create all the items in the cart
class CartGrid extends StatelessWidget {
  final List<CartItem> items;
  const CartGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width < 600
        ? 2
        : width < 900
        ? 3
        : 4;

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.68,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) => CartTile(item: items[i]),
    );
  }
}
