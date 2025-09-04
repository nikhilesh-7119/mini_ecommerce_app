import 'package:flutter/material.dart';
import 'widgets/home_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    //intentionally thin for future scalability
    return const HomeScaffold();
  }
}
