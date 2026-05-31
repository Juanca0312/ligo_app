import 'package:flutter/material.dart';
import 'package:ligo_app/app/router/app_router.dart';
import 'package:ligo_app/core/theme/light_theme.dart';

/// The main app widget for the Ligo application.
class LigoApp extends StatelessWidget {
  /// Creates a [LigoApp] widget.
  const LigoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: LigoLightTheme.light,
      routerConfig: AppRouter.router,
      builder: (context, child) => child!,
    );
  }
}
