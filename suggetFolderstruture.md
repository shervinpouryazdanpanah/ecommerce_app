## Recommended Hybrid Folder Structure (GraphQL + REST + GetX)

```bash
lib/
│
├── main.dart
│
├── app/                       # App-wide config and bindings
│   ├── bindings/
│   │   └── initial_binding.dart
│   ├── routes/
│   │   └── routes.dart
│   └── themes/
│       ├── app_theme.dart
│       └── theme_controller.dart
│
├── core/                      # Core services used throughout app
│   ├── services/
│   │   ├── graphql_service.dart     # Ferry setup
│   │   └── api_client.dart          # Dio + Retrofit setup
│   └── utils/
│       ├── logger.dart
│       └── helpers.dart
│
├── data/                      # Shared models, repositories, and data sources
│   ├── models/
│   │   └── product_model.dart       # Shared model (used by GraphQL or REST)
│   ├── repositories/
│   │   ├── product_repository_rest.dart
│   │   └── product_repository_graphql.dart
│   └── datasources/
│       ├── product_rest_api.dart     # Retrofit implementation
│       └── product_graphql_api.dart  # Ferry implementation
│
├── graphql/                   # Global GraphQL files (not module-specific)
│   ├── schema.graphql
│   ├── generated/
│   │   ├── schema.ast.gql.dart
│   │   ├── schema.schema.gql.dart
│   │   ├── schema.schema.gql.g.dart
│   │   ├── serializers.gql.dart
│   │   └── serializers.gql.g.dart
│
├── modules/                   # Feature-based folder structure
│   ├── home/
│   │   ├── views/
│   │   │   └── home_view.dart
│   │   └── controllers/
│   │       └── home_controller.dart
│   │
│   ├── product/
│   │   ├── bindings/
│   │   │   └── product_binding.dart
│   │   ├── controllers/
│   │   │   └── product_controller.dart
│   │   ├── views/
│   │   │   └── product_view.dart
│   │   ├── graphql/
│   │   │   ├── get_products.graphql
│   │   │   └── generated/
│   │   │       ├── get_products.req.gql.dart
│   │   │       ├── get_products.data.gql.dart
│   │   │       └── ...
│   │   └── rest/
│   │       └── product_api.dart   # REST-only implementation if needed
│   │
│   └── auth/
│       ├── views/
│       ├── controllers/
│       ├── bindings/
│       └── graphql/
│
├── shared/                    # Shared global constants, UI, localization
│   ├── constants/
│   │   ├── api_constants.dart
│   │   └── assets.dart
│   ├── localization/
│   │   ├── en_US.dart
│   │   ├── fa_IR.dart
│   │   └── translations.dart
│   └── widgets/
│       └── appbar.dart
```

---

## ✅ Highlights

| Folder                               | Purpose                                     |
| ------------------------------------ | ------------------------------------------- |
| `core/services/`                     | Global clients (Retrofit/Dio + Ferry)       |
| `data/models/`                       | Shared models used by both REST and GraphQL |
| `data/repositories/`                 | Abstracts logic behind both API styles      |
| `modules/[feature]/graphql/`         | Feature-specific queries/mutations          |
| `modules/[feature]/rest/`            | Feature-specific REST APIs if needed        |
| `shared/`                            | Reusable components and resources           |
| `app/themes/`, `app/bindings/`, etc. | App-wide config & setup                     |

---

## 🔁 Usage Flow Examples

### If using REST for Products:

- Controller calls `ProductRepositoryRest().getProducts()`
- Uses `Dio` client via `core/services/api_client.dart`

### If using GraphQL for Products:

- Controller calls `ProductRepositoryGraphQL().getProducts()`
- Uses `FerryClient` via `core/services/graphql_service.dart`
