import 'package:dio/dio.dart';
import 'package:ecommerce/app/themes/theme_controller.dart';
import 'package:ecommerce/core/services/api_client.dart';
import 'package:ecommerce/shared/constants/app_constants.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());

    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.endpoint,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    final apiClient = ApiClient(dio);
    Get.put<ApiClient>(apiClient);
  }
}
