import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce_app/models/product.dart';
import 'package:mini_ecommerce_app/screens/productDetail_screen.dart/widgets/detail_description.dart';
import 'package:mini_ecommerce_app/screens/productDetail_screen.dart/widgets/detail_image.dart';
import 'package:mini_ecommerce_app/screens/productDetail_screen.dart/widgets/detail_tile.dart';
import 'package:mini_ecommerce_app/screens/productDetail_screen.dart/widgets/price_rating_row.dart';
import 'package:mini_ecommerce_app/controller/cart_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final double horizontal = size.width < 600 ? 16 : 24;
    final double imageHeight = size.height * (size.width < 600 ? 0.38 : 0.45);

    final Product product = Get.arguments as Product;
    final cart = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(product.category ?? 'Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailImage(imageUrl: product.image, height: imageHeight),
              const SizedBox(height: 16),
              DetailTitle(title: product.title),
              const SizedBox(height: 12),
              if ((product.description).toString().isNotEmpty)
                DetailDescription(description: product.description ?? ''),
              if ((product.description).toString().isNotEmpty)
                const SizedBox(height: 16),
              PriceRatingRow(
                price: product.price,
                rate: product.rating.rate,
                count: product.rating.count,
              ),
              const SizedBox(height: 24),
              Center(
                child: Obx(() {
                  final bool isInCart = cart.isInCart(product.id);
                  return FilledButton(
                    onPressed: () {
                      if (!isInCart) {
                        cart.addProduct(product); // adds with qty=1
                      } else {
                        // cart.increment(product.id); // controller enforces max 10
                      }
                    },
                    child: Text(isInCart ? 'Added' : 'Add to cart'),
                  );
                }),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
