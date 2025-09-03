
import 'package:flutter/material.dart';

class DetailDescription extends StatelessWidget {
  final String description;
  const DetailDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      description,
      softWrap: true,
      style: theme.textTheme.bodyMedium,
    );
  }
}