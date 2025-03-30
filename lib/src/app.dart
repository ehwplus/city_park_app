import 'package:city_park_app/src/pages/home_page.dart';
import 'package:city_park_app/src/settings/theme_settings_controller.dart';
import 'package:flutter/material.dart';

import 'l10n/generated/app_localizations.dart';

class CityParkApp extends StatelessWidget {
  const CityParkApp({
    super.key,
    required this.settingsController,
  });

  final ThemeSettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (BuildContext context) =>
      AppLocalizations.of(context)!.appTitle,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      themeMode: settingsController.themeMode,
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}