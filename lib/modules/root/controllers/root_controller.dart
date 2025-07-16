// modules/root/controllers/root_controller.dart
import 'package:get/get.dart';

class RootController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final tabs = ['/home', '/products', '/profile'];

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
