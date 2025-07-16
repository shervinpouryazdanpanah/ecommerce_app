## 🧠 Project Overview

You're building a simple **Product List App** that:

- Uses `GetX` for state management, dependency injection, and routing.
- Uses `Retrofit` and `Dio` to fetch product data from `https://fakestoreapi.com/products`.
- Displays the product list in a clean UI.

---

## 🔧 Project Structure Summary

```bash
app/
├── bindings/initial_binding.dart       → Global DI setup
├── routes/routes.dart                  → Route definitions
├── themes/
│   ├── app_theme.dart                  → App theme (light/dark)
│   └── theme_controller.dart           → Theme controller using GetX

core/
└── services/api_client.dart            → Retrofit API service

modules/
└── products/
    ├── controllers/product_controller.dart  → Product controller using GetX
    ├── models/product_model.dart            → Product model (from API)
    ├── products_binding.dart                → Controller binding for products
    └── views/products_view.dart             → UI to show product list

main.dart                             → App entry point
```

---

## 🔵 `main.dart` – Entry Point

```dart
import 'package:flutter/material.dart';               // Flutter core widgets
import 'package:get/get.dart';                        // GetX core
import 'app/bindings/initial_binding.dart';           // Global bindings
import 'app/routes/routes.dart';                      // Routing config
import 'app/themes/app_theme.dart';                   // Theme setup

void main() {
  runApp(MyApp());                                    // Launch the app
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(                            // Replace MaterialApp with GetMaterialApp
      debugShowCheckedModeBanner: false,
      title: 'Fake Store',
      theme: AppTheme.light,                          // Light theme
      initialBinding: InitialBinding(),               // Bind global services
      getPages: AppRoutes.routes,                     // Setup routing
    );
  }
}
```

---

## 🧩 `initial_binding.dart` – Dependency Injection

```dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../core/services/api_client.dart';
import '../themes/theme_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());                       // Inject ThemeController globally

    final dio = Dio(BaseOptions(                      // Create Dio instance with options
      baseUrl: 'https://fakestoreapi.com/',           // API base URL
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    final apiClient = ApiClient(dio);                 // Create Retrofit client
    Get.put<ApiClient>(apiClient);                    // Inject ApiClient globally
  }
}
```

---

## 🎨 `app_theme.dart` – Light/Dark Themes

```dart
import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(                     // Light theme
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
  );

  static final dark = ThemeData(                      // Dark theme
    brightness: Brightness.dark,
  );
}
```

---

## 🎛️ `theme_controller.dart` – Optional GetX Theme Switching

```dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  var themeMode = ThemeMode.system.obs;               // Observable for ThemeMode

  void toggleTheme(bool isDark) {                     // Method to toggle theme
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
```

---

## 🧭 `routes.dart` – Navigation Setup

```dart
import 'package:get/get.dart';
import '../../modules/products/products_binding.dart';
import '../../modules/products/views/products_view.dart';

class AppRoutes {
  static final routes = [                             // List of app pages
    GetPage(
      name: '/',                                       // Default route
      page: () => ProductsView(),                     // Widget to show
      binding: ProductsBinding(),                     // Inject controller for this route
    ),
  ];
}
```

---

## 🌐 `api_client.dart` – Retrofit API Interface

```dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../modules/products/models/product_model.dart';

part 'api_client.g.dart';                             // Auto-generated file

@RestApi(baseUrl: "https://fakestoreapi.com/")        // Retrofit base URL
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/products")                                   // Endpoint to fetch all products
  Future<List<ProductModel>> getProducts();
}
```

You generate `api_client.g.dart` with:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🧱 `product_model.dart` – Product Data Model

```dart
class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        title: json['title'],
        price: (json['price'] as num).toDouble(),
        description: json['description'],
        category: json['category'],
        image: json['image'],
      );
}
```

---

## 🧠 `product_controller.dart` – GetX Controller Logic

```dart
import 'package:get/get.dart';
import '../../../core/services/api_client.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  final ApiClient apiClient = Get.find();             // Get API service

  var isLoading = false.obs;                          // Loading state
  var products = <ProductModel>[].obs;                // Product list state

  @override
  void onInit() {
    super.onInit();
    fetchProducts();                                  // Fetch products on controller init
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);                                // Show loading
      final result = await apiClient.getProducts();   // API call
      products.assignAll(result);                     // Assign data to list
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products');
    } finally {
      isLoading(false);                               // Hide loading
    }
  }
}
```

---

## 🔗 `products_binding.dart` – Inject Controller for Route

```dart
import 'package:get/get.dart';
import 'controllers/product_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());           // Inject ProductController lazily
  }
}
```

---

## 🖼️ `products_view.dart` – User Interface

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';

class ProductsView extends GetView<ProductController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(\"Fake Store\")),
      body: Obx(() {                                    // Reactively update UI
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
              subtitle: Text(\"\\$${product.price.toStringAsFixed(2)}\"),
            );
          },
        );
      }),
    );
  }
}
```

---

## ✅ Summary of What Each File Does

| File                            | Purpose                                                         |
| ------------------------------- | --------------------------------------------------------------- |
| `main.dart`                     | Starts the app, initializes routing, theme, and bindings.       |
| `initial_binding.dart`          | Injects global services (theme + API client) before app starts. |
| `api_client.dart`               | Retrofit API definition (fetch products from REST API).         |
| `product_model.dart`            | Converts JSON product into Dart object.                         |
| `product_controller.dart`       | Handles product fetching and exposes reactive variables.        |
| `products_binding.dart`         | Injects the `ProductController` for the product route.          |
| `products_view.dart`            | Displays UI using `ListView` and updates reactively via `Obx`.  |
| `routes.dart`                   | Defines navigation for product view.                            |
| `app_theme.dart` / `controller` | (Optional) Light/dark theming with GetX control.                |
