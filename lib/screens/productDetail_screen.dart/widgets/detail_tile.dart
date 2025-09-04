import 'package:flutter/material.dart';

class DetailTitle extends StatelessWidget {
  final String title;
  const DetailTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      softWrap: true,
      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
