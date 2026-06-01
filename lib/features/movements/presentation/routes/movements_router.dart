import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ligo_app/core/di/service_locator.dart';
import 'package:ligo_app/features/movements/domain/cubits/movements/movements_cubit.dart';
import 'package:ligo_app/features/movements/presentation/pages/movements_page.dart';
import 'package:ligo_app/features/movements/presentation/routes/movements_routes.dart';

/// Router configuration for movements feature.
class MovementsRouter {
  /// List of routes for the movements feature.
  static List<RouteBase> router = [
    GoRoute(
      path: MovementsRoutes.movements.path,
      name: MovementsRoutes.movements.name,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<MovementsCubit>(),
        child: const MovementsPage(),
      ),
    ),
  ];
}
