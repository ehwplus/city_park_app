import 'package:city_park_app/src/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class ImpressumPage extends StatelessWidget {
  const ImpressumPage({super.key});

  static const routeName = '/settings/impressum';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.impressumTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(l10n.impressumDescription),
      ),
    );
  }
}
