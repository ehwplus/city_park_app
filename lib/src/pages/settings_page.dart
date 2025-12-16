import 'package:city_park_app/src/l10n/generated/app_localizations.dart';
import 'package:city_park_app/src/model/localization/locale_provider.dart';
import 'package:city_park_app/src/pages/impressum_page.dart';
import 'package:city_park_app/src/pages/privacy_page.dart';
import 'package:city_park_app/src/pages/ticket_management_page.dart';
import 'package:fl_ui_config/fl_ui_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  ThemeMode? _selectedThemeMode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(localeProvider);
    final themeMode = _selectedThemeMode ?? context.themeMode;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          ListTile(
            title: Text(l10n.settingsThemeTitle),
            subtitle: Text(_themeLabel(l10n, themeMode)),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              onChanged: (mode) {
                if (mode != null) {
                  setState(() {
                    _selectedThemeMode = mode;
                  });
                  context.saveThemeMode(mode);
                }
              },
              items: [
                DropdownMenuItem(value: ThemeMode.system, child: Text(l10n.settingsThemeSystem)),
                DropdownMenuItem(value: ThemeMode.light, child: Text(l10n.settingsThemeLight)),
                DropdownMenuItem(value: ThemeMode.dark, child: Text(l10n.settingsThemeDark)),
              ],
            ),
          ),
          ListTile(
            title: Text(l10n.settingsLanguageTitle),
            subtitle: Text(_languageLabel(l10n, locale)),
            trailing: DropdownButton<Locale?>(
              value: locale,
              onChanged: (value) {
                ref.read(localeProvider.notifier).setLocale(value);
              },
              items: [
                DropdownMenuItem(value: null, child: Text(l10n.settingsLanguageSystem)),
                DropdownMenuItem(value: const Locale('de'), child: Text(l10n.settingsLanguageGerman)),
                DropdownMenuItem(value: const Locale('en'), child: Text(l10n.settingsLanguageEnglish)),
              ],
            ),
          ),
          ListTile(
            title: Text(l10n.settingsTicketsTileTitle),
            subtitle: Text(l10n.settingsTicketsTileSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(TicketManagementPage.routeName),
          ),
          ListTile(
            title: Text(l10n.settingsPrivacyTileTitle),
            subtitle: Text(l10n.settingsPrivacyTileSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(PrivacyPage.routeName),
          ),
          ListTile(
            title: Text(l10n.settingsImpressumTileTitle),
            subtitle: Text(l10n.settingsImpressumTileSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(ImpressumPage.routeName),
          ),
        ],
      ),
    );
  }
}

String _themeLabel(AppLocalizations l10n, ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return l10n.settingsThemeLight;
    case ThemeMode.dark:
      return l10n.settingsThemeDark;
    case ThemeMode.system:
      return l10n.settingsThemeSystem;
  }
}

String _languageLabel(AppLocalizations l10n, Locale? locale) {
  switch (locale?.languageCode) {
    case 'de':
      return l10n.settingsLanguageGerman;
    case 'en':
      return l10n.settingsLanguageEnglish;
    default:
      return l10n.settingsLanguageSystem;
  }
}
