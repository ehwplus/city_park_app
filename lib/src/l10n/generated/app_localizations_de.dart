// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Stadtpark App';

  @override
  String get tabArrival => 'Anfahrt';

  @override
  String get tabTickets => 'Eintritt';

  @override
  String get tabMap => 'Karte';

  @override
  String get tabEvents => 'Veranstaltungen';

  @override
  String get tabArrivalDescription =>
      'Finde den schnellsten Weg zum Park – per ÖPNV, Fahrrad oder Auto.';

  @override
  String get tabTicketsDescription =>
      'Infos zu Tickets, Preisen und Öffnungszeiten auf einen Blick.';

  @override
  String get tabMapDescription =>
      'Erkunde den Parkplan und entdecke Highlights in der Nähe.';

  @override
  String get tabEventsDescription =>
      'Aktuelle Events, Führungen und Termine im Park.';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get privacyTitle => 'Datenschutz';

  @override
  String get impressumTitle => 'Impressum';

  @override
  String get privacyDescription =>
      'Hier stehen Hinweise zur Datenerhebung, -speicherung und -nutzung. Füge hier eure vollständige Datenschutzerklärung ein.';

  @override
  String get impressumDescription =>
      'Füge hier die Impressumsangaben (Anbieter, Kontakt, Verantwortliche) ein.';

  @override
  String get settingsPrivacyTileTitle => 'Datenschutz';

  @override
  String get settingsPrivacyTileSubtitle =>
      'Informationen zur Verarbeitung deiner Daten';

  @override
  String get settingsImpressumTileTitle => 'Impressum';

  @override
  String get settingsImpressumTileSubtitle => 'Angaben gemäß § 5 TMG';

  @override
  String get ticketsSeasonPassQuestion => 'Du besitzt eine Dauerkarte?';

  @override
  String get ticketsAddSeasonPassButton => 'Dauerkarte hinzufügen';

  @override
  String get ticketsAvailableInfo =>
      'Du hast bereits gespeicherte Dauerkarten.';

  @override
  String get settingsTicketsTileTitle => 'Tickets';

  @override
  String get settingsTicketsTileSubtitle =>
      'Gespeicherte Dauerkarten verwalten';

  @override
  String get ticketsManagementTitle => 'Tickets';

  @override
  String get ticketsManagementEmpty =>
      'Du hast noch keine Dauerkarten gespeichert.';

  @override
  String get ticketsManagementRemove => 'Entfernen';

  @override
  String parkStatusClosing(String parkName, int minutes, String time) {
    return 'Der $parkName schließt in $minutes Minuten. Der Park ist heute bis $time Uhr geöffnet.';
  }

  @override
  String parkStatusOpensToday(String parkName, int minutes, String time) {
    return 'Der $parkName öffnet in $minutes Minuten um $time Uhr.';
  }

  @override
  String parkStatusOpensFuture(String parkName, String when, String time) {
    return 'Der $parkName öffnet erst $when um $time Uhr wieder.';
  }

  @override
  String get whenTomorrow => 'morgen';

  @override
  String get whenDayAfterTomorrow => 'übermorgen';

  @override
  String get openingHoursNext7Days => 'Öffnungszeiten der nächsten 7 Tage';

  @override
  String get openingHoursClosed => 'Geschlossen';

  @override
  String get openingHoursNotFound => 'Keine Öffnungszeiten gefunden.';
}
