import 'package:city_park_app/src/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  static const routeName = '/settings/privacy';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.privacyTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Datenschutz-Informationen nach DSGVO', style: theme.textTheme.titleLarge),
          const SizedBox(height: 20),
          _Section(
            title: 'Verantwortlicher',
            body: [
              'Verantwortlich für die Datenverarbeitung: EHW+ Services GmbH, E-Mail: info@ehwplus.com, Telefon: 06204/74441.',
              'Datenschutzbeauftragter: Timo Bähr.',
            ],
          ),
          _Section(
            title: 'Verarbeitete Daten',
            body: [
              'Nutzungsdaten: z. B. Log-Daten, Geräteinformationen, App-Version.',
              'Inhalts-/Formulardaten: gespeicherte Tickets, gewählte Parks, optionale Eingaben im Rahmen der Ticketverwaltung.',
              'Standortdaten: nur, wenn ihr die Berechtigung erteilt; können jederzeit in den Geräteeinstellungen widerrufen werden.',
              'Keine Verarbeitung besonderer Kategorien personenbezogener Daten (Art. 9 DSGVO).',
            ],
          ),
          _Section(
            title: 'Zwecke und Rechtsgrundlagen',
            body: [
              'Bereitstellung und Betrieb der App, Ticketverwaltung: Art. 6 Abs. 1 lit. b DSGVO (Vertrag/vertragsähnliches Verhältnis).',
              'Fehleranalyse, Stabilität, Sicherheit (z. B. Logfiles, Crash-Reports): Art. 6 Abs. 1 lit. f DSGVO (berechtigtes Interesse an einer sicheren und stabilen App).',
              'Optionale Dienste (z. B. Analytik/Marketing, Standortfunktionen): Art. 6 Abs. 1 lit. a DSGVO (Einwilligung); widerrufbar mit Wirkung für die Zukunft.',
            ],
          ),
          _Section(
            title: 'Drittanbieter',
            body: [
              'Einsatz von Auftragsverarbeitern nur mit Vertrag nach Art. 28 DSGVO.',
              'Keine Weitergabe an Dritte.',
            ],
          ),
          _Section(
            title: 'Datenübermittlung in Drittländer',
            body: ['Es werden keine Daten in Drittländer übermittelt.'],
          ),
          _Section(
            title: 'Speicherdauer und Löschung',
            body: [
              'Personenbezogene Daten werden gelöscht, sobald sie für die genannten Zwecke nicht mehr erforderlich sind oder gesetzliche Aufbewahrungsfristen enden.',
              'Lokal gespeicherte Daten (z. B. Tickets, Park-Auswahl) könnt ihr in der App oder über die Geräteeinstellungen löschen.',
            ],
          ),
          _Section(
            title: 'Rechte der betroffenen Personen',
            body: [
              'Auskunft (Art. 15), Berichtigung (Art. 16), Löschung (Art. 17), Einschränkung (Art. 18), Datenübertragbarkeit (Art. 20).',
              'Widerspruch gegen Verarbeitungen auf Grundlage von Art. 6 Abs. 1 lit. f DSGVO (Art. 21); keine zwingenden Gründe nachweisen? Dann unterbleibt die Verarbeitung.',
              'Widerruf erteilter Einwilligungen (Art. 7 Abs. 3) mit Wirkung für die Zukunft.',
              'Beschwerderecht bei einer Aufsichtsbehörde (Art. 77), z. B. an eurem Aufenthaltsort oder dem Sitz des Verantwortlichen.',
            ],
          ),
          _Section(
            title: 'Sicherheit',
            body: [
              'Transportverschlüsselung (TLS) und rollenbasierte Zugriffskonzepte.',
              'Technisch-organisatorische Maßnahmen zur Verfügbarkeit, Vertraulichkeit und Integrität.',
            ],
          ),
          _Section(
            title: 'Minderjährige',
            body: [
              'Die App richtet sich an Nutzer ab 6 Jahren. Sofern jünger, bitte Zustimmung der Erziehungsberechtigten sicherstellen.',
            ],
          ),
          _Section(
            title: 'Aktualisierungen',
            body: ['Wir passen diese Hinweise an, wenn sich die Datenverarbeitung ändert. Stand: 5.1.2026.'],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});

  final String title;
  final List<String> body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          ...body.map((text) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(text))),
        ],
      ),
    );
  }
}
