import 'package:go_router/go_router.dart';
import 'package:ligo_app/features/movements/presentation/pages/movements_page.dart';
import 'package:ligo_app/features/movements/presentation/routes/movements_routes.dart';

/// Router configuration for movements feature.
class MovementsRouter {
  /// List of routes for the movements feature.
  static List<RouteBase> router = [
    GoRoute(
      path: MovementsRoutes.movements.path,
      name: MovementsRoutes.movements.name,
      builder: (context, state) => const MovementsPage(),
    ),
  ];
}
