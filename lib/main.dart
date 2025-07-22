import 'package:ecommerce/login.dart';
import 'package:ecommerce/categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final routes = [
    GetPage(name: '/login', page: () => Login()),
    GetPage(name: '/categories', page: () => Categories()),
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/categories',
      getPages: routes,
    );
  }
}
