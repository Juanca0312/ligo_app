import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';
import 'package:ligo_app/core/widgets/widgets.dart';
import 'package:ligo_app/features/auth/domain/cubits/session/session_cubit.dart';
import 'package:ligo_app/features/auth/domain/entities/session_status.dart';
import 'package:ligo_app/features/auth/presentation/routes/auth_routes.dart';

/// A wrapper widget that listens to session changes and redirects to the login
class AuthWrapper extends StatelessWidget {
  /// Creates an [AuthWrapper] widget
  const AuthWrapper({
    required this.child,
    super.key,
  });

  /// The child widget to wrap with the authentication listener
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == SessionStatus.unauthenticated) {
          LigoSnackBar.show(
            context,
            message: context.localized.sessionExpired,
            type: .error,
          );

          context.goNamed(AuthRoutes.login.name);
        }
      },
      child: child,
    );
  }
}
