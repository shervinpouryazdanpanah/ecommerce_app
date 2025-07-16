import 'package:ecommerce/core/services/api_client.dart';
import 'package:ecommerce/shared/models/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ApiClient apiClient = Get.find();

  var isLoading = false.obs;
  var products = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final result = await apiClient.getProducts();
      products.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products');
    } finally {
      isLoading(false);
    }
  }
}
