import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ligo_app/core/common/ligo_assets.dart';
import 'package:ligo_app/core/presentation/cubits/session/session_cubit.dart';
import 'package:ligo_app/core/theme/ligo_spacing.dart';
import 'package:ligo_app/features/auth/domain/entities/session_status.dart';
import 'package:ligo_app/features/auth/presentation/routes/auth_routes.dart';
import 'package:ligo_app/features/movements/presentation/routes/movements_routes.dart';

/// The splash page of the app, shown while determining the session status.
class SplashPage extends StatefulWidget {
  /// Creates a [SplashPage] widget.
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    unawaited(context.read<SessionCubit>().restoreSession());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status && curr.status != SessionStatus.unknown,
      listener: (context, state) {
        if (state.status == SessionStatus.authenticated) {
          context.goNamed(MovementsRoutes.movements.name);
        } else {
          context.goNamed(AuthRoutes.login.name);
        }
      },
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(LigoAssets.logo, width: 150),
            const SizedBox(height: LigoSpacing.xl),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
