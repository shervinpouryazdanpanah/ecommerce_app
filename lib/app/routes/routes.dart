import 'package:ecommerce/modules/product/product_binding.dart';
import 'package:ecommerce/modules/product/views/product_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => ProductsView(), binding: ProductsBinding()),
  ];
}
