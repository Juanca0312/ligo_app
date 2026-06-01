import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ligo_app/core/di/service_locator.dart';
import 'package:ligo_app/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:ligo_app/features/movements/presentation/cubits/movements/movements_cubit.dart';
import 'package:ligo_app/features/movements/presentation/pages/movement_detail_page.dart';
import 'package:ligo_app/features/movements/presentation/pages/movements_page.dart';
import 'package:ligo_app/features/movements/presentation/routes/movements_routes.dart';

/// Router configuration for movements feature.
class MovementsRouter {
  /// ShellRoute for the movements feature with auth protection.
  static RouteBase router = ShellRoute(
    builder: (context, state, child) {
      return AuthWrapper(
        child: BlocProvider(
          create: (context) => getIt<MovementsCubit>(),
          child: child,
        ),
      );
    },
    routes: [
      GoRoute(
        path: MovementsRoutes.movements.path,
        name: MovementsRoutes.movements.name,
        builder: (context, state) => const MovementsPage(),
        routes: [
          GoRoute(
            path: MovementsRoutes.movementDetail.path,
            name: MovementsRoutes.movementDetail.name,
            builder: (context, state) {
              final movementId = state.pathParameters['id']!;
              return MovementDetailPage(movementId: movementId);
            },
          ),
        ],
      ),
    ],
  );
}
