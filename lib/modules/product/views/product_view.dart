import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';

class ProductsView extends GetView<ProductController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fake Store")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return ListTile(
              leading: Image.network(
                product.image,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
              title: Text(product.title),
              subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
            );
          },
        );
      }),
    );
  }
}
