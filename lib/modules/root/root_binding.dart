// modules/root/root_binding.dart
import 'package:ecommerce/modules/product/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RootController());
    Get.lazyPut(() => ProductController());
  }
}
