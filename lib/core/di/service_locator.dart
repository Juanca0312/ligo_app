import 'package:get_it/get_it.dart';
import 'package:ligo_app/core/di/auth_dependencies.dart';
import 'package:ligo_app/core/di/core_dependencies.dart';
import 'package:ligo_app/core/di/movements_dependencies.dart';

/// Service locator for dependency injection using GetIt.
final GetIt getIt = GetIt.instance;

/// Sets up all dependencies for the app.
void setupDependencies() {
  setupCoreDependencies();
  setupAuthDependencies();
  setupMovementsDependencies();
}
