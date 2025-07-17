Here's a complete **Flutter GetX architecture example** that uses both **REST API (via Dio/Retrofit)** and **GraphQL (via Ferry)** in one app — with:

- ✅ Pagination
- ✅ Filtering (e.g., by category)
- ✅ A shared controller that handles both APIs

---

## ✅ Backend Source

We’re using:
🛍️ [`https://fakestoreapi.com/products`](https://fakestoreapi.com/products)
Example filtering: `https://fakestoreapi.com/products/category/jewelery`
There is no official pagination in FakeStore API, so we'll **simulate it client-side**.

---

## 🧩 Folder Structure (Core Parts Only)

```bash
lib/
├── main.dart
├── core/
│   └── services/
│       ├── api_client.dart           # Dio/Retrofit
│       └── graphql_service.dart      # Ferry client
├── data/
│   ├── models/
│   │   └── product.dart
│   ├── repositories/
│   │   ├── product_rest_repository.dart
│   │   └── product_graphql_repository.dart
├── modules/
│   └── products/
│       ├── controllers/
│       │   └── product_controller.dart
│       ├── views/
│       │   └── product_view.dart
│       └── graphql/
│           ├── get_products.graphql
│           └── generated/...
```

---

## 🧱 1. Model: `product.dart`

```dart
class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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

## 🌐 2. REST Setup

### `api_client.dart` (Retrofit)

```dart
@RestApi(baseUrl: "https://fakestoreapi.com/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("products")
  Future<List<Product>> getProducts();

  @GET("products/category/{category}")
  Future<List<Product>> getProductsByCategory(@Path() String category);
}
```

### `product_rest_repository.dart`

```dart
class ProductRestRepository {
  final ApiClient api;

  ProductRestRepository(this.api);

  Future<List<Product>> fetchAll({String? category}) {
    if (category != null && category.isNotEmpty) {
      return api.getProductsByCategory(category);
    }
    return api.getProducts();
  }
}
```

---

## 🔷 3. GraphQL Setup

### `get_products.graphql`

```graphql
query GetProducts {
  products {
    id
    title
    price
    description
    category
    image
  }
}
```

### `product_graphql_repository.dart`

```dart
class ProductGraphQLRepository {
  final GraphQLService service;

  ProductGraphQLRepository(this.service);

  Future<List<Product>> fetchAll() async {
    final req = GGetProductsReq(); // auto-gen
    final response = await service.client.request(req).first;

    final raw = response.data?.products;
    if (raw == null) return [];

    return raw.map((e) => Product(
      id: e.id,
      title: e.title,
      price: e.price,
      description: e.description,
      category: e.category,
      image: e.image,
    )).toList();
  }
}
```

---

## 🎯 4. Controller: `product_controller.dart`

```dart
class ProductController extends GetxController {
  final ProductRestRepository restRepo;
  final ProductGraphQLRepository gqlRepo;

  ProductController({
    required this.restRepo,
    required this.gqlRepo,
  });

  final products = <Product>[].obs;
  final isLoading = false.obs;
  final category = ''.obs;
  final currentPage = 1.obs;
  final itemsPerPage = 10;

  bool useGraphQL = false;

  Future<void> loadProducts({bool reset = false}) async {
    isLoading(true);
    if (reset) {
      products.clear();
      currentPage(1);
    }

    try {
      List<Product> result = [];

      if (useGraphQL) {
        result = await gqlRepo.fetchAll();
      } else {
        result = await restRepo.fetchAll(category: category.value);
      }

      // Simulate pagination (local for FakeStore)
      final start = (currentPage.value - 1) * itemsPerPage;
      final end = start + itemsPerPage;
      final pageSlice = result.skip(start).take(itemsPerPage).toList();

      products.addAll(pageSlice);
      currentPage.value++;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  void applyCategory(String newCategory) {
    category(newCategory);
    loadProducts(reset: true);
  }

  void toggleApiType() {
    useGraphQL = !useGraphQL;
    loadProducts(reset: true);
  }
}
```

---

## 🖼 5. View: `product_view.dart`

```dart
class ProductView extends StatelessWidget {
  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: controller.toggleApiType,
            tooltip: "Switch API (GraphQL/REST)",
          )
        ],
      ),
      body: Column(
        children: [
          // Filter
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: controller.category.value.isEmpty ? null : controller.category.value,
              hint: const Text("Select category"),
              items: ['electronics', 'jewelery', 'men\'s clothing', 'women\'s clothing']
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (val) => controller.applyCategory(val ?? ''),
            ),
          ),
          // Products
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.products.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: controller.products.length + 1,
                itemBuilder: (_, index) {
                  if (index == controller.products.length) {
                    return TextButton(
                      onPressed: controller.loadProducts,
                      child: const Text("Load more"),
                    );
                  }

                  final p = controller.products[index];
                  return ListTile(
                    leading: Image.network(p.image, width: 50, height: 50),
                    title: Text(p.title),
                    subtitle: Text("\$${p.price}"),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
```

---

## 🔌 6. Inject in Binding

```dart
class ProductBinding extends Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    final apiClient = ApiClient(dio);
    final graphql = GraphQLService();

    Get.put(ProductController(
      restRepo: ProductRestRepository(apiClient),
      gqlRepo: ProductGraphQLRepository(graphql),
    ));
  }
}
```

---

## ✅ Output Features

- Switch between **GraphQL** and **REST API**
- Simulated **pagination**
- **Filtering** by category
- Modular, clean, GetX-friendly
