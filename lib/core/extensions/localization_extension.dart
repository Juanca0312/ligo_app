import 'package:flutter/widgets.dart';
import 'package:ligo_app/l10n/app_localizations.dart';

/// Extension on [BuildContext] to provide easy access to localized strings.
extension LocalizationExtension on BuildContext {
  /// Provides access to the localized strings for the current context.
  AppLocalizations get localized => AppLocalizations.of(this)!;
}
