
import 'package:flutter/material.dart';

class PriceRatingRow extends StatelessWidget {
  final double price;
  final double rate;
  final int count;
  const PriceRatingRow({
    required this.price,
    required this.rate,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('\$${price.toStringAsFixed(2)}', style: theme.textTheme.headlineSmall),
        Row(
          children: [
            const Icon(Icons.star, size: 18, color: Colors.amber),
            const SizedBox(width: 4),
            Text(rate.toStringAsFixed(1), style: theme.textTheme.bodyLarge),
            const SizedBox(width: 6),
            Text('($count)', style: theme.textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
