import 'package:ecommerce/shared/models/product_model.dart';
import 'package:ecommerce/shared/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: AppConstants.endpoint)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/products")
  Future<List<ProductModel>> getProducts();
}
