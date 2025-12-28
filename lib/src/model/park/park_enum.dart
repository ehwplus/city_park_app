import 'package:city_park_app/src/model/opening_hours/opening_hours.dart';
import 'package:city_park_app/src/model/opening_hours/opening_hours_for_different_parks.dart';

enum ParkEnum {
  EssenGrugapark(
    name: 'Grugapark',
    city: 'Essen',
    assetFolder: 'essen_grugapark',
    buyTicketUrl: 'https://pretix.eu/grugapark/eintrittskarten/',
  ),
  DortmundWestfalenpark(
    name: 'Westfalenpark',
    city: 'Dortmund',
    assetFolder: 'dortmund_westfalenpark',
    buyTicketUrl: 'https://shop.ticketpay.de/organizer/TTGU9J70/calendar',
  ),
  MannheimLuistenpark(
    name: 'Luisenpark',
    city: 'Mannheim',
    assetFolder: 'mannheim_luisenpark',
    buyTicketUrl: 'https://shop.luisenpark.de/',
  ),
  MannheimHerzogenriedpark(
    name: 'Herzogenriedpark',
    city: 'Mannheim',
    assetFolder: 'mannheim_herzogenriedpark',
    buyTicketUrl: 'https://shop.herzogenriedpark.de/',
  );

  const ParkEnum({required this.name, required this.city, required this.assetFolder, required this.buyTicketUrl});

  final String name;

  final String city;

  final String buyTicketUrl;

  final String assetFolder;

  String get assetPath => 'assets/$assetFolder/logo.svg';
}

extension OpeningHoursExtension on ParkEnum {
  List<OpeningHours> get openingHours {
    switch (this) {
      case ParkEnum.EssenGrugapark:
        return openingHoursGrugapark;
      case ParkEnum.MannheimLuistenpark:
        return openingHoursLuisenpark;
      case ParkEnum.MannheimHerzogenriedpark:
        return openingHoursHerzogenriedpark;
      case ParkEnum.DortmundWestfalenpark:
        return openingHoursWestfalenpark;
    }
  }
}
