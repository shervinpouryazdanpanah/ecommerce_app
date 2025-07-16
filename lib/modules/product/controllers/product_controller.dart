import 'package:get/get.dart';
import '../../../core/services/api_client.dart';
import '../models/product_model.dart';

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
