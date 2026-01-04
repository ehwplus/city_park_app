// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My park';

  @override
  String get tabArrival => 'Arrival';

  @override
  String get tabTickets => 'Tickets';

  @override
  String get tabMap => 'Expore';

  @override
  String get tabEvents => 'Events';

  @override
  String get tabArrivalDescription =>
      'Find the best route to the park by public transport, bike, or car.';

  @override
  String get tabTicketsDescription =>
      'Details on tickets, prices, and opening times at a glance.';

  @override
  String get tabMapDescription =>
      'Explore the park and discover highlights nearby.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get privacyTitle => 'Privacy';

  @override
  String get impressumTitle => 'Imprint';

  @override
  String get privacyDescription =>
      'Information about how your data is collected, stored, and used. Replace with your full privacy policy.';

  @override
  String get impressumDescription =>
      'Add legal provider information, contact, and responsible persons here.';

  @override
  String get settingsPrivacyTileTitle => 'Privacy';

  @override
  String get settingsPrivacyTileSubtitle =>
      'Information about how your data is handled';

  @override
  String get settingsImpressumTileTitle => 'Imprint';

  @override
  String get settingsImpressumTileSubtitle =>
      'Information required by law (e.g. provider, contact)';

  @override
  String get ticketSingle => 'Single ticket';

  @override
  String get ticketSeasonPass => 'Season pass';

  @override
  String get ticketsSelectCardType => 'Please choose the ticket type';

  @override
  String get ticketsSeasonPassQuestion => 'Do you have a season pass?';

  @override
  String get ticketsAddSeasonPassButton => 'Add season pass';

  @override
  String get ticketsAddTicketButton => 'Add ticket';

  @override
  String get ticketsAvailableInfo => 'Would you like to add more tickets?';

  @override
  String get settingsTicketsTileTitle => 'Tickets';

  @override
  String get settingsTicketsTileSubtitle => 'Manage saved season passes';

  @override
  String get ticketsManagementTitle => 'Tickets';

  @override
  String get ticketsManagementEmpty =>
      'You have not saved any season passes yet.';

  @override
  String get ticketsManagementRemove => 'Remove';

  @override
  String get ticketsBuyTicketButton => 'Buy ticket';

  @override
  String get ticketsOpenShopError => 'Could not open ticket shop.';

  @override
  String parkStatusClosing(String parkName, int minutes, String time) {
    return 'The $parkName closes in $minutes minutes. It is open today until $time.';
  }

  @override
  String parkStatusOpensToday(String parkName, int minutes, String time) {
    return 'The $parkName opens in $minutes minutes at $time.';
  }

  @override
  String parkStatusOpensFuture(String parkName, String when, String time) {
    return 'The $parkName opens again $when at $time.';
  }

  @override
  String get whenTomorrow => 'tomorrow';

  @override
  String get whenDayAfterTomorrow => 'the day after tomorrow';

  @override
  String get openingHoursNext7Days => 'Opening hours for the next 7 days';

  @override
  String get openingHoursClosed => 'Closed';

  @override
  String get openingHoursNotFound => 'No opening hours found.';

  @override
  String get settingsThemeTitle => 'Appearance';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageSystem => 'System';

  @override
  String get settingsLanguageGerman => 'Deutsch';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get ticketsAddTitle => 'Add season pass';

  @override
  String get ticketsFormFirstName => 'First name';

  @override
  String get ticketsFormLastName => 'Last name';

  @override
  String get ticketsFormBirthday => 'Birthday (YYYY-MM-DD)';

  @override
  String get ticketsFormInvalidDate => 'Datum muss YYYY-MM-DD sein';

  @override
  String get ticketsFormCardNumber => 'Card number';

  @override
  String get ticketsFormBarCode => 'Bar code';

  @override
  String get ticketsFormQrCode => 'QR code';

  @override
  String get ticketsFormScanBarCodeButton => 'Scan bar code';

  @override
  String get ticketsFormScanQRCodeButton => 'QR-Code scannen';

  @override
  String get ticketsFormParksLabel => 'Valid in parks';

  @override
  String get ticketsFormExpirationDate => 'Expiration date (YYYY-MM-DD)';

  @override
  String get ticketsQrDialogTitle => 'QR code';

  @override
  String get ruhrTopcard => 'Ruhr.Topcard';

  @override
  String get ruhrTopcardConditions =>
      'Entitles you to one-time admission to the following parks:';
}
