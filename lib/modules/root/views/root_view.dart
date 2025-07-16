// modules/root/views/root_view.dart
import 'package:ecommerce/modules/home/views/home_view.dart';
import 'package:ecommerce/modules/product/views/product_view.dart';
import 'package:ecommerce/modules/profile/views/profile_view.dart';
import 'package:ecommerce/modules/root/controllers/root_controller.dart';
import 'package:ecommerce/shared/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});

  final List<Widget> pages = const [
    HomeView(),
    ProductsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[controller.currentIndex.value],
          bottomNavigationBar: BottomNavWidget(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
          ),
        ));
  }
}
