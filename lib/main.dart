import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/bindings/initial_binding.dart';
import 'app/routes/routes.dart';
import 'app/themes/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fake Store',
      theme: AppTheme.light,
      initialBinding: InitialBinding(),
      getPages: AppRoutes.routes,
    );
  }
}
