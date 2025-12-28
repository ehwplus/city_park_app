import 'package:city_park_app/src/model/opening_hours/opening_hours.dart';
import 'package:city_park_app/src/model/opening_hours/opening_hours_for_different_parks.dart';
import 'package:city_park_app/src/model/park/last_used_park_provider.dart';
import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the opening hours for the currently selected park.
///
/// Falls back to Essen Grugapark when no park has been chosen yet.
final openingHoursProvider = Provider<List<OpeningHours>>((ref) {
  final park = ref.watch(lastUsedParkProvider) ?? ParkEnum.essenGrugapark;
  return park.openingHours;
});
