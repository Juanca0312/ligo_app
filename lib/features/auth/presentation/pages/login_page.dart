import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ligo_app/core/common/ligo_assets.dart';
import 'package:ligo_app/core/extensions/failure_localization_extension.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';
import 'package:ligo_app/core/presentation/widgets/widgets.dart';
import 'package:ligo_app/core/theme/ligo_spacing.dart';
import 'package:ligo_app/features/auth/domain/validators/auth_validators.dart';
import 'package:ligo_app/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:ligo_app/features/movements/presentation/routes/movements_routes.dart';

/// The login page of the application, allowing users to enter their credentials
class LoginPage extends StatelessWidget {
  /// Creates a [LoginPage] widget.
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.authRequestStatus != current.authRequestStatus,
      listener: (context, state) {
        if (state.isSuccess) {
          LigoSnackBar.show(
            context,
            type: .success,
            message: context.localized.loginSuccess,
          );
          context.goNamed(MovementsRoutes.movements.name);
        }

        if (state.isFailure) {
          LigoSnackBar.show(
            context,
            type: .error,
            message:
                state.failure?.localize(context) ??
                context.localized.genericError,
          );
        }
      },
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  static const _maxFormWidth = 400.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.only(
            right: LigoSpacing.l,
            left: LigoSpacing.l,
            top: LigoSpacing.xxxl,
            bottom: LigoSpacing.xxl,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: _maxFormWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Image.asset(
                    LigoAssets.logo,
                    width: 120,
                  ),
                ),

                const SizedBox(height: LigoSpacing.l),

                LigoTextFormField(
                  hintText: context.localized.email,
                  keyboardType: TextInputType.emailAddress,
                  errorText: context.select<AuthCubit, String?>(
                    (cubit) => cubit.state.email.error?.localize(context),
                  ),
                  onChanged: (value) =>
                      context.read<AuthCubit>().updateEmail(value),
                ),

                const SizedBox(height: LigoSpacing.m),

                LigoTextFormField(
                  hintText: context.localized.password,
                  obscureText: true,
                  errorText: context.select<AuthCubit, String?>(
                    (cubit) => cubit.state.password.error?.localize(context),
                  ),
                  onChanged: (value) =>
                      context.read<AuthCubit>().updatePassword(value),
                ),

                const SizedBox(height: LigoSpacing.xl),

                LigoButton(
                  onPressed: () => context.read<AuthCubit>().login(),
                  isLoading: context.select<AuthCubit, bool>(
                    (cubit) => cubit.state.isLoading,
                  ),
                  isEnabled: context.select<AuthCubit, bool>(
                    (cubit) => cubit.state.isFormValid,
                  ),
                  text: context.localized.login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
