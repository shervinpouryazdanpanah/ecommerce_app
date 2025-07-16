import 'package:ecommerce/modules/home/views/home_view.dart';
import 'package:ecommerce/modules/product/product_binding.dart';
import 'package:ecommerce/modules/product/views/product_view.dart';
import 'package:ecommerce/modules/profile/views/profile_view.dart';
import 'package:ecommerce/modules/root/root_binding.dart';
import 'package:ecommerce/modules/root/views/root_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const RootView(), binding: RootBinding()),
    GetPage(name: '/home', page: () => const HomeView()),
    GetPage(
        name: '/products',
        page: () => ProductsView(),
        binding: ProductBinding()),
    GetPage(name: '/profile', page: () => const ProfileView()),
  ];
}
