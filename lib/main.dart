import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_ecommerce_app/assets/themes/darkTheme.dart';
import 'package:mini_ecommerce_app/assets/themes/lightTheme.dart';
import 'package:mini_ecommerce_app/controller/cart_controller.dart';
import 'package:mini_ecommerce_app/controller/home_controller.dart';
import 'package:mini_ecommerce_app/data_sources/product_repositories.dart';
import 'package:mini_ecommerce_app/data_sources/remote_source.dart';
import 'package:mini_ecommerce_app/screens/homeScreen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isBoxOpen('productsBox')) {
    await Hive.openBox('productsBox');
  }
  if (!Hive.isBoxOpen('cartBox')) {
    await Hive.openBox('cartBox');
  }

  // DI wiring AFTER boxes are open
  final remoteSource = RemoteSource();
  final productRepository = ProductRepository(remoteSource: remoteSource);

  Get.put<HomeController>(
    HomeController(productRepository: productRepository),
    permanent: true,
  );
  Get.put(CartController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mini E-Commerce',
      theme: Lighttheme.theme,
      darkTheme: Darktheme.theme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
