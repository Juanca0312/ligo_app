import 'package:go_router/go_router.dart';
import 'package:ligo_app/features/auth/presentation/routes/auth_router.dart';
import 'package:ligo_app/features/auth/presentation/routes/auth_routes.dart';
import 'package:ligo_app/features/movements/presentation/routes/movements_router.dart';

/// The main router for the app, which includes all feature routes.
class AppRouter {
  /// The router configuration for the app, which includes all feature routes.
  static final router = GoRouter(
    initialLocation: AuthRoutes.login.path,
    routes: [
      ...AuthRouter.router,
      ...MovementsRouter.router,
    ],
  );
}
