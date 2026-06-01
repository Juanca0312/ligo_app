import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ligo_app/core/di/service_locator.dart';
import 'package:ligo_app/features/auth/domain/cubits/auth/auth_cubit.dart';
import 'package:ligo_app/features/auth/presentation/pages/login_page.dart';
import 'package:ligo_app/features/auth/presentation/routes/auth_routes.dart';

/// Router configuration for authentication feature.
class AuthRouter {
  /// List of routes for the authentication feature.
  static List<RouteBase> router = [
    GoRoute(
      path: AuthRoutes.login.path,
      name: AuthRoutes.login.name,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const LoginPage(),
      ),
    ),
  ];
}
