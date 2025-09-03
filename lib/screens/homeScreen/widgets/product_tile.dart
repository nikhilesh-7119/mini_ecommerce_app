import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce_app/models/product.dart';
import 'package:mini_ecommerce_app/screens/productDetail_screen.dart/product_detail_screen.dart';
import 'package:mini_ecommerce_app/controller/cart_controller.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cart = Get.find<CartController>();

    // Derive membership reactively so the button updates when cart changes
    return Obx(() {
      final bool isInCart = cart.isInCart(product.id);

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Tappable area for navigating to details (image)
              Expanded(
                flex: 6,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Get.to(() => const ProductDetailScreen(), arguments: product),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Make title + price/rating tappable to detail
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Get.to(() => const ProductDetailScreen(), arguments: product),
                child: Column(
                  children: [
                    // Title (2 lines)
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    // Price left, Rating right
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: theme.textTheme.labelLarge,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(product.rating.rate.toStringAsFixed(1)),
                            const SizedBox(width: 4),
                            Text(
                              '(${product.rating.count})',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Centered small button: Add or Added(+1)
              Align(
                alignment: Alignment.center,
                child: FilledButton(
                  onPressed: () {
                    if (!isInCart) {
                      cart.addProduct(product);
                    } else {
                      // cart.increment(product.id); // cap handled in controller (max 10)
                    }
                  },
                  child: Text(isInCart ? 'Added' : 'Add to cart'),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
