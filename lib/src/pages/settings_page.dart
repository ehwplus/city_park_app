import 'package:city_park_app/src/l10n/generated/app_localizations.dart';
import 'package:city_park_app/src/pages/impressum_page.dart';
import 'package:city_park_app/src/pages/privacy_page.dart';
import 'package:city_park_app/src/pages/ticket_management_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          ListTile(
            title: Text(l10n.settingsTicketsTileTitle),
            subtitle: Text(l10n.settingsTicketsTileSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap:
                () => Navigator.of(
                  context,
                ).pushNamed(TicketManagementPage.routeName),
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
            onTap:
                () => Navigator.of(context).pushNamed(ImpressumPage.routeName),
          ),
        ],
      ),
    );
  }
}
