import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ligo_app/app/router/app_router.dart';
import 'package:ligo_app/core/theme/light_theme.dart';
import 'package:ligo_app/l10n/app_localizations.dart';

/// The main app widget for the Ligo application.
class LigoApp extends StatelessWidget {
  /// Creates a [LigoApp] widget.
  const LigoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: LigoLightTheme.light,
      routerConfig: AppRouter.router,
      builder: (context, child) => child!,
    );
  }
}
