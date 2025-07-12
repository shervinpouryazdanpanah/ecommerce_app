#!/bin/bash

mkdir -p lib/app/{bindings,routes,themes}
touch lib/app/bindings/initial_binding.dart
touch lib/app/routes/routes.dart
touch lib/app/themes/{app_theme.dart,theme_controller.dart}

mkdir -p lib/core/database/{daos,entities}
touch lib/core/database/app_database.dart
touch lib/core/database/daos/sample_dao.dart
touch lib/core/database/entities/sample_task.dart
mkdir -p lib/core/services
touch lib/core/services/drift_service.dart

mkdir -p lib/modules/sample/{controllers,models,views,widgets}
touch lib/modules/sample/sample_binding.dart
touch lib/modules/sample/controllers/sample_controller.dart
touch lib/modules/sample/models/sample_model.dart
touch lib/modules/sample/views/sample_view.dart
touch lib/modules/sample/widgets/sample_timer_widget.dart

mkdir -p lib/shared/{constants,localization,widgets}
touch lib/shared/constants/drift_constants.dart

echo "✅ Folder structure created successfully."
