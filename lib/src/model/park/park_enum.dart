import 'package:city_park_app/src/model/opening_hours/opening_hours.dart';
import 'package:city_park_app/src/model/opening_hours/opening_hours_for_different_parks.dart';

enum ParkEnum {
  essenGrugapark(
    name: 'Grugapark',
    city: 'Essen',
    assetFolder: 'essen_grugapark',
    buyTicketUrl: 'https://pretix.eu/grugapark/eintrittskarten/',
    eventsUrl: 'https://www.grugapark.de/erleben/veranstaltungskalender_2/veranstaltungskalender.de.html',
  ),
  dortmundWestfalenpark(
    name: 'Westfalenpark',
    city: 'Dortmund',
    assetFolder: 'dortmund_westfalenpark',
    buyTicketUrl: 'https://shop.ticketpay.de/organizer/TTGU9J70/calendar',
    eventsUrl: 'https://www.dortmund.de/dortmund-erleben/freizeit-und-kultur/westfalenpark/die-veranstaltungen/',
  ),
  mannheimLuisenpark(
    name: 'Luisenpark',
    city: 'Mannheim',
    assetFolder: 'mannheim_luisenpark',
    buyTicketUrl: 'https://shop.luisenpark.de/',
    eventsUrl: 'https://www.luisenpark.de/veranstaltungen/kalender',
  ),
  mannheimHerzogenriedpark(
    name: 'Herzogenriedpark',
    city: 'Mannheim',
    assetFolder: 'mannheim_herzogenriedpark',
    buyTicketUrl: 'https://shop.herzogenriedpark.de/',
    eventsUrl: 'https://www.herzogenriedpark.de/veranstaltungen/kalender',
  );

  const ParkEnum({
    required this.name,
    required this.city,
    required this.assetFolder,
    required this.buyTicketUrl,
    required this.eventsUrl,
  });

  final String name;

  final String city;

  final String buyTicketUrl;

  final String eventsUrl;

  final String assetFolder;

  String get assetPath => 'assets/$assetFolder/logo.svg';
}

extension OpeningHoursExtension on ParkEnum {
  List<OpeningHours> get openingHours {
    switch (this) {
      case ParkEnum.essenGrugapark:
        return openingHoursGrugapark;
      case ParkEnum.mannheimLuisenpark:
        return openingHoursLuisenpark;
      case ParkEnum.mannheimHerzogenriedpark:
        return openingHoursHerzogenriedpark;
      case ParkEnum.dortmundWestfalenpark:
        return openingHoursWestfalenpark;
    }
  }
}
