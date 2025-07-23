# 🛍️ Product List App (Flutter + GetX + REST + GraphQL)

A production-ready Flutter app demonstrating how to build a product listing interface using:

- ✅ **GetX** for state management, routing, and DI
- ✅ **Retrofit** and **Dio** for REST API calls
- ✅ **Ferry** for GraphQL support
- ✅ Clean architecture with feature-based modularization
- ✅ Runtime switching between REST and GraphQL
- ✅ Category filtering and client-side pagination

---

## 🌍 Backend API

> Product data is retrieved from:
> **[`https://fakestoreapi.com/products`](https://fakestoreapi.com/products)**

Example filtering:

```bash
GET /products/category/jewelery
```

ℹ️ No official pagination support → handled manually in the app.

---

## ✨ Features

- ✅ REST API + GraphQL API support
- ✅ Filter by category
- ✅ Client-side pagination
- ✅ Toggle between REST and GraphQL at runtime
- ✅ Modular code with separation of concerns
- ✅ Responsive UI with GetX state management
- ✅ Theming support (light/dark/system)

---

## 📁 Full Folder Structure (Complete + Explained)

```bash
lib/
├── main.dart                        # App entry point

├── app/                             # App-wide configuration and utilities
│   ├── bindings/
│   │   └── initial_binding.dart     # Global DI (Dio, Theme, GraphQL client, etc.)
│   ├── routes/
│   │   └── routes.dart              # GetX route definitions
│   └── themes/
│       ├── app_theme.dart           # Light and dark theme configurations
│       └── theme_controller.dart    # GetX controller to manage theme mode

├── core/                            # Global services and foundational utilities
│   └── services/
│       ├── api_client.dart          # Retrofit client setup with Dio
│       └── graphql_service.dart     # Ferry GraphQL client setup

├── data/                            # Centralized data layer (shared across modules)
│   ├── models/
│   │   └── product_model.dart       # Shared product model for REST and GraphQL
│   ├── repositories/
│   │   ├── product_repository_rest.dart     # Wrapper around REST API client
│   │   └── product_repository_graphql.dart  # Wrapper around GraphQL service
│   └── datasources/                 # Optional: abstract layer for services
│       ├── product_rest_api.dart           # REST data provider
│       └── product_graphql_api.dart        # GraphQL data provider

├── graphql/                         # Global GraphQL config
│   ├── schema.graphql               # (Optional) shared schema
│   ├── generated/                   # Ferry-generated files (AST, requests, serializers, etc.)
│   │   ├── schema.schema.gql.dart
│   │   ├── serializers.gql.dart
│   │   └── ...

├── modules/                         # Feature-based app modules
│   └── product/
│       ├── bindings/
│       │   └── product_binding.dart     # Binds ProductController with dependencies
│       ├── controllers/
│       │   └── product_controller.dart  # Handles logic, switching APIs, pagination
│       ├── views/
│       │   └── product_view.dart        # UI layout with filtering and list
│       ├── graphql/
│       │   ├── get_products.graphql     # GraphQL query
│       │   └── generated/               # Ferry-generated query files
│       │       └── get_products.req.gql.dart
│       └── rest/
│           └── product_api.dart         # Optional REST-specific service class

├── shared/                          # Reusable resources
│   ├── constants/
│   │   ├── api_constants.dart           # Base URLs and endpoints
│   │   └── assets.dart                  # Paths to images/icons
│   ├── localization/
│   │   ├── en_US.dart
│   │   ├── fa_IR.dart
│   │   └── translations.dart
│   └── widgets/
│       └── appbar.dart                  # Reusable UI widgets (e.g. app bar, buttons)
```

---

## 📊 Data Flow

### 🔹 Using REST:

1. `ProductController` → `ProductRepositoryRest`
2. Repository uses `ApiClient` (Retrofit + Dio)
3. Result updates `RxList<Product>`

### 🔹 Using GraphQL:

1. `ProductController` → `ProductRepositoryGraphQL`
2. Repository uses `GraphQLService` + Ferry request
3. Result updates same `RxList<Product>`

---

## 🧠 Important Files Explained

| File                      | Role                                                    |
| ------------------------- | ------------------------------------------------------- |
| `main.dart`               | App entry, initializes bindings and routes              |
| `initial_binding.dart`    | Registers global services (API, GraphQL, Theme)         |
| `product_controller.dart` | Handles fetching, switching APIs, filtering, pagination |
| `product_view.dart`       | Displays list of products, filters, and loading states  |
| `product_model.dart`      | Unified model for both APIs                             |
| `api_client.dart`         | Retrofit interface for REST                             |
| `graphql_service.dart`    | Ferry GraphQL setup                                     |
| `get_products.graphql`    | GraphQL query for product list                          |
| `theme_controller.dart`   | Manages theme switching                                 |
| `routes.dart`             | GetX routing setup                                      |
| `product_binding.dart`    | Connects controller and dependencies to routes          |

---

## 🧪 API Switching Example

```dart
// In AppBar
IconButton(
  icon: Icon(Icons.swap_horiz),
  onPressed: controller.toggleApiType,
  tooltip: "Switch API (GraphQL / REST)",
)
```

---

## 📦 Install + Generate Code

### Dependencies

```bash
flutter pub get
```

### Retrofit Codegen

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Ferry Codegen (GraphQL)

Ferry codegen must be set up separately (usually via `gql_build` or similar).

---

## 🔗 Tips for Extending

- Add categories to API call to support filtering.
- Wrap pagination logic inside the repositories for real API support.
- Abstract `ProductRepository` interface for cleaner architecture.
- Add error logging and retry mechanisms.

---

## 📘 Final Thoughts

This hybrid example is a great foundation for:

- API-driven Flutter apps
- Multi-architecture testing (REST vs GraphQL)
- Clean and modular code structure using GetX
- Expandable architecture for scaling into real-world apps
