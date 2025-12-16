import 'package:city_park_app/src/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  static const routeName = '/settings/privacy';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.privacyTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(l10n.privacyDescription),
      ),
    );
  }
}
