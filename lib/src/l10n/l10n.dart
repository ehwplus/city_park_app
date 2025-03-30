import 'package:flutter/widgets.dart';
import 'package:city_park_app/src/l10n/generated/app_localizations.dart';

export 'package:city_park_app/src/l10n/generated/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}