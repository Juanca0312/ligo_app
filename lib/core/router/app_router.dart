import 'package:go_router/go_router.dart';
import 'package:ligo_app/core/presentation/widgets/pages/splash_page.dart';
import 'package:ligo_app/features/auth/presentation/routes/auth_router.dart';
import 'package:ligo_app/features/movements/presentation/routes/movements_router.dart';

/// The main router for the app, which includes all feature routes.
class AppRouter {
  /// Returns a [GoRouter] configured with all the routes for the app.
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      ...AuthRouter.router,
      MovementsRouter.router,
    ],
  );
}
