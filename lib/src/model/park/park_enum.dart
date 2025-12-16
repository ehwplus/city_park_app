import 'package:city_park_app/src/model/opening_hours/opening_hours.dart';
import 'package:city_park_app/src/model/opening_hours/opening_hours_for_different_parks.dart';

enum ParkEnum {
  EssenGrugapark(name: 'Grugapark', city: 'Essen', assetFolder: 'essen_grugapark'),
  DortmundWestfalenpark(name: 'Westfalenpark', city: 'Dortmund', assetFolder: 'dortmund_westfalenpark'),
  MannheimLuistenpark(name: 'Luisenpark', city: 'Mannheim', assetFolder: 'mannheim_herzogenriedpark'),
  MannheimHerzogenriedpark(name: 'Herzogenriedpark', city: 'Mannheim', assetFolder: 'mannheim_luisenpark');

  const ParkEnum({required this.name, required this.city, required this.assetFolder});

  final String name;

  final String city;

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
