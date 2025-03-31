enum ParkEnum {
  EssenGrugapark(name: 'Grugapark', city: 'Essen', assetFolder: 'essen_grugapark'),
  MannheimLuistenpark(name: 'Luisenpark', city: 'Mannheim', assetFolder: 'mannheim_herzogenriedpark'),
  MannheimHerzogenriedpark(name: 'Herzogenriedpark', city: 'Mannheim', assetFolder: 'mannheim_luisenpark');

  const ParkEnum({required this.name, required this.city, required this.assetFolder});

  final String name;

  final String city;

  final String assetFolder;

  String get assetPath => 'assets/$assetFolder/logo.svg';
}