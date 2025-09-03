import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce_app/controller/cart_controller.dart';
import 'package:mini_ecommerce_app/models/cart_item.dart';

class CartTile extends GetView<CartController> {
  final CartItem item;
  const CartTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: item.image,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text('\$${item.price.toStringAsFixed(2)}',
                style: theme.textTheme.labelLarge),
            const Spacer(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Plus on left
                  IconButton(
                    tooltip: 'Increase',
                    onPressed: item.quantity >= 10 ? null : () => controller.increment(item.id),
                    icon: const Icon(Icons.add_circle),
                  ),
                  // Quantity in middle
                  Text(
                    '${item.quantity}',
                    style: theme.textTheme.titleMedium,
                  ),
                  // Minus on right
                  IconButton(
                    tooltip: 'Decrease',
                    onPressed: () => controller.decrement(item.id),
                    icon: const Icon(Icons.remove_circle),
                  ),
                  // Delete button beside controls
                  IconButton(
                    tooltip: 'Delete',
                    onPressed: () => controller.removeById(item.id),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
