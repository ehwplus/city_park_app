import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// App für euren Stadtpark
  ///
  /// In de, this message translates to:
  /// **'Mein Park'**
  String get appTitle;

  /// Tab-Titel für Anfahrt
  ///
  /// In de, this message translates to:
  /// **'Anfahrt'**
  String get tabArrival;

  /// Tab-Titel für Eintritt
  ///
  /// In de, this message translates to:
  /// **'Eintritt'**
  String get tabTickets;

  /// Tab-Titel für Karte/Entdecken
  ///
  /// In de, this message translates to:
  /// **'Entdecken'**
  String get tabMap;

  /// Tab-Titel für Veranstaltungen
  ///
  /// In de, this message translates to:
  /// **'Veranstaltungen'**
  String get tabEvents;

  /// Beschreibung Anfahrt
  ///
  /// In de, this message translates to:
  /// **'Finde den schnellsten Weg zum Park – per ÖPNV, Fahrrad oder Auto.'**
  String get tabArrivalDescription;

  /// Beschreibung Eintritt
  ///
  /// In de, this message translates to:
  /// **'Infos zu Tickets, Preisen und Öffnungszeiten auf einen Blick.'**
  String get tabTicketsDescription;

  /// Beschreibung Karte
  ///
  /// In de, this message translates to:
  /// **'Erkunde den Park und entdecke Highlights in der Nähe.'**
  String get tabMapDescription;

  /// Titel Einstellungen
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settingsTitle;

  /// Titel Datenschutz
  ///
  /// In de, this message translates to:
  /// **'Datenschutz'**
  String get privacyTitle;

  /// Titel Impressum
  ///
  /// In de, this message translates to:
  /// **'Impressum'**
  String get impressumTitle;

  /// Text Datenschutz
  ///
  /// In de, this message translates to:
  /// **'Hier stehen Hinweise zur Datenerhebung, -speicherung und -nutzung. Füge hier eure vollständige Datenschutzerklärung ein.'**
  String get privacyDescription;

  /// Text Impressum
  ///
  /// In de, this message translates to:
  /// **'Füge hier die Impressumsangaben (Anbieter, Kontakt, Verantwortliche) ein.'**
  String get impressumDescription;

  /// Listeneintrag Datenschutz Titel
  ///
  /// In de, this message translates to:
  /// **'Datenschutz'**
  String get settingsPrivacyTileTitle;

  /// Listeneintrag Datenschutz Untertitel
  ///
  /// In de, this message translates to:
  /// **'Informationen zur Verarbeitung deiner Daten'**
  String get settingsPrivacyTileSubtitle;

  /// Listeneintrag Impressum Titel
  ///
  /// In de, this message translates to:
  /// **'Impressum'**
  String get settingsImpressumTileTitle;

  /// Listeneintrag Impressum Untertitel
  ///
  /// In de, this message translates to:
  /// **'Angaben gemäß § 5 TMG'**
  String get settingsImpressumTileSubtitle;

  /// No description provided for @ticketSingle.
  ///
  /// In de, this message translates to:
  /// **'Einzelkarte'**
  String get ticketSingle;

  /// No description provided for @ticketSeasonPass.
  ///
  /// In de, this message translates to:
  /// **'Dauerkarte'**
  String get ticketSeasonPass;

  /// No description provided for @ticketsSelectCardType.
  ///
  /// In de, this message translates to:
  /// **'Wähle den gewünschten Ticket-Typ'**
  String get ticketsSelectCardType;

  /// Frage wenn keine Dauerkarte gespeichert ist
  ///
  /// In de, this message translates to:
  /// **'Du besitzt eine Dauerkarte?'**
  String get ticketsSeasonPassQuestion;

  /// No description provided for @ticketsAddSeasonPassButton.
  ///
  /// In de, this message translates to:
  /// **'Dauerkarte hinzufügen'**
  String get ticketsAddSeasonPassButton;

  /// Buttonbeschriftung zum Hinzufügen einer Karte
  ///
  /// In de, this message translates to:
  /// **'Karte hinzufügen'**
  String get ticketsAddTicketButton;

  /// Info wenn Dauerkarten vorhanden sind
  ///
  /// In de, this message translates to:
  /// **'Willst du weitere Tickets hinzufügen?'**
  String get ticketsAvailableInfo;

  /// Listeneintrag Tickets Titel
  ///
  /// In de, this message translates to:
  /// **'Tickets'**
  String get settingsTicketsTileTitle;

  /// Listeneintrag Tickets Untertitel
  ///
  /// In de, this message translates to:
  /// **'Gespeicherte Dauerkarten verwalten'**
  String get settingsTicketsTileSubtitle;

  /// Titel Ticket-Verwaltungsseite
  ///
  /// In de, this message translates to:
  /// **'Tickets'**
  String get ticketsManagementTitle;

  /// Leertext Ticket-Verwaltung
  ///
  /// In de, this message translates to:
  /// **'Du hast noch keine Dauerkarten gespeichert.'**
  String get ticketsManagementEmpty;

  /// Label für Entfernen-Aktion bei Ticket
  ///
  /// In de, this message translates to:
  /// **'Entfernen'**
  String get ticketsManagementRemove;

  /// Buttonbeschriftung zum Ticketkauf im Browser
  ///
  /// In de, this message translates to:
  /// **'Ticket kaufen'**
  String get ticketsBuyTicketButton;

  /// Fehlermeldung wenn der Ticketshop nicht geöffnet werden konnte
  ///
  /// In de, this message translates to:
  /// **'Ticketshop konnte nicht geöffnet werden.'**
  String get ticketsOpenShopError;

  /// Status wenn der Park jetzt geöffnet ist
  ///
  /// In de, this message translates to:
  /// **'Der {parkName} schließt in {minutes} Minuten. Der Park ist heute bis {time} Uhr geöffnet.'**
  String parkStatusClosing(String parkName, int minutes, String time);

  /// Status wenn der Park später am gleichen Tag öffnet
  ///
  /// In de, this message translates to:
  /// **'Der {parkName} öffnet in {minutes} Minuten um {time} Uhr.'**
  String parkStatusOpensToday(String parkName, int minutes, String time);

  /// Status wenn der Park erst an einem späteren Tag öffnet
  ///
  /// In de, this message translates to:
  /// **'Der {parkName} öffnet erst {when} um {time} Uhr wieder.'**
  String parkStatusOpensFuture(String parkName, String when, String time);

  /// Wort für morgen
  ///
  /// In de, this message translates to:
  /// **'morgen'**
  String get whenTomorrow;

  /// Wort für übermorgen
  ///
  /// In de, this message translates to:
  /// **'übermorgen'**
  String get whenDayAfterTomorrow;

  /// Überschrift für Liste der nächsten Öffnungszeiten
  ///
  /// In de, this message translates to:
  /// **'Öffnungszeiten der nächsten 7 Tage'**
  String get openingHoursNext7Days;

  /// Label für geschlossene Tage
  ///
  /// In de, this message translates to:
  /// **'Geschlossen'**
  String get openingHoursClosed;

  /// Text wenn keine Zeiten vorhanden
  ///
  /// In de, this message translates to:
  /// **'Keine Öffnungszeiten gefunden.'**
  String get openingHoursNotFound;

  /// Einstellungstitel für Theme/Design
  ///
  /// In de, this message translates to:
  /// **'Darstellung'**
  String get settingsThemeTitle;

  /// Theme-Option System
  ///
  /// In de, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// Theme-Option Hell
  ///
  /// In de, this message translates to:
  /// **'Hell'**
  String get settingsThemeLight;

  /// Theme-Option Dunkel
  ///
  /// In de, this message translates to:
  /// **'Dunkel'**
  String get settingsThemeDark;

  /// Einstellungstitel für Sprache
  ///
  /// In de, this message translates to:
  /// **'Sprache'**
  String get settingsLanguageTitle;

  /// Sprach-Option System
  ///
  /// In de, this message translates to:
  /// **'System'**
  String get settingsLanguageSystem;

  /// Sprach-Option Deutsch
  ///
  /// In de, this message translates to:
  /// **'Deutsch'**
  String get settingsLanguageGerman;

  /// Sprach-Option Englisch
  ///
  /// In de, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// Seitentitel für das Hinzufügen einer Dauerkarte
  ///
  /// In de, this message translates to:
  /// **'Dauerkarte hinzufügen'**
  String get ticketsAddTitle;

  /// Formularfeld Vorname
  ///
  /// In de, this message translates to:
  /// **'Vorname'**
  String get ticketsFormFirstName;

  /// Formularfeld Nachname
  ///
  /// In de, this message translates to:
  /// **'Nachname'**
  String get ticketsFormLastName;

  /// Formularfeld Geburtsdatum
  ///
  /// In de, this message translates to:
  /// **'Geburtsdatum (YYYY-MM-DD)'**
  String get ticketsFormBirthday;

  /// Fehlermeldung für ungültiges Geburtsdatum
  ///
  /// In de, this message translates to:
  /// **'Datum muss YYYY-MM-DD sein'**
  String get ticketsFormInvalidDate;

  /// Formularfeld Kartennummer
  ///
  /// In de, this message translates to:
  /// **'Kartennummer'**
  String get ticketsFormCardNumber;

  /// Formularfeld QR-Code
  ///
  /// In de, this message translates to:
  /// **'Bar-Code'**
  String get ticketsFormBarCode;

  /// Formularfeld QR-Code
  ///
  /// In de, this message translates to:
  /// **'QR-Code'**
  String get ticketsFormQrCode;

  /// Button zum Scannen des Bar-Codes
  ///
  /// In de, this message translates to:
  /// **'Bar-Code scannen'**
  String get ticketsFormScanBarCodeButton;

  /// No description provided for @ticketsFormScanQRCodeButton.
  ///
  /// In de, this message translates to:
  /// **'QR-Code scannen'**
  String get ticketsFormScanQRCodeButton;

  /// Label für Parkauswahl
  ///
  /// In de, this message translates to:
  /// **'Gültig in Parks'**
  String get ticketsFormParksLabel;

  /// No description provided for @ticketsFormExpirationDate.
  ///
  /// In de, this message translates to:
  /// **'Ablaufdatum (YYYY-MM-DD)'**
  String get ticketsFormExpirationDate;

  /// Titel für QR-Code-Dialog
  ///
  /// In de, this message translates to:
  /// **'QR-Code'**
  String get ticketsQrDialogTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
