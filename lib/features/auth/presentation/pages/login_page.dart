import 'package:flutter/material.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';
import 'package:ligo_app/core/theme/ligo_spacing.dart';
import 'package:ligo_app/core/widgets/widgets.dart';
import 'package:ligo_app/features/auth/presentation/assets/auth_assets.dart';

/// Login page.
class LoginPage extends StatelessWidget {
  /// Creates a [LoginPage] widget.
  const LoginPage({super.key});

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
                    AuthAssets.logo,
                    width: 120,
                  ),
                ),

                const SizedBox(height: LigoSpacing.l),

                LigoTextFormField(
                  hintText: context.localized.email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {},
                ),

                const SizedBox(height: LigoSpacing.m),

                LigoTextFormField(
                  hintText: context.localized.password,
                  obscureText: true,
                  onChanged: (value) {},
                ),

                const SizedBox(height: LigoSpacing.xl),

                LigoButton(
                  onPressed: () {},
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
