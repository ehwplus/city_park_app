import 'package:city_park_app/src/pages/add_ticket_page.dart';
import 'package:city_park_app/src/pages/home_page.dart';
import 'package:city_park_app/src/pages/impressum_page.dart';
import 'package:city_park_app/src/pages/privacy_page.dart';
import 'package:city_park_app/src/pages/settings_page.dart';
import 'package:city_park_app/src/pages/ticket_management_page.dart';
import 'package:city_park_app/src/model/localization/locale_provider.dart';
import 'package:fl_ui_config/fl_ui_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/generated/app_localizations.dart';

class CityParkApp extends StatelessWidget {
  const CityParkApp({super.key, required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return StatefulWidgetWithUiConfig(
      uiConfig: UiConfig(
        appName: 'Stadtpark',
        defaultColorPalette: ColorPalette.fromMaterialColor(
          primary: Colors.red,
        ),
      ),
      uiConfigManager: SharedPreferencesUiConfigManager(
        sharedPreferences: sharedPreferences,
      ),
      builder: ({
        String? alternativeColorPaletteKey,
        required ThemeMode themeMode,
        required bool isHighContrastEnabled,
      }) {
        final themeLight = uiConfig.lightTheme(
          alternativeMode: alternativeColorPaletteKey,
        );
        final themeDark = uiConfig.darkTheme(
          alternativeMode: alternativeColorPaletteKey,
        );

        return Consumer(
          builder: (context, ref, _) {
            final locale = ref.watch(localeProvider);
            return MaterialApp(
              // Provide the generated AppLocalizations to the MaterialApp. This
              // allows descendant Widgets to display the correct translations
              // depending on the user's locale.
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: locale,

              // Use AppLocalizations to configure the correct application title
              // depending on the user's locale.
              //
              // The appTitle is defined in .arb files found in the localization
              // directory.
              onGenerateTitle:
                  (BuildContext context) =>
                      AppLocalizations.of(context)!.appTitle,

              theme: themeLight,
              darkTheme: themeDark,
              themeMode: themeMode,
              home: const HomePage(),
              routes: {
                SettingsPage.routeName: (_) => const SettingsPage(),
                PrivacyPage.routeName: (_) => const PrivacyPage(),
                ImpressumPage.routeName: (_) => const ImpressumPage(),
                TicketManagementPage.routeName:
                    (_) => const TicketManagementPage(),
                AddTicketPage.routeName: (_) => const AddTicketPage(),
              },
            );
          },
        );
      },
    );
  }
}
