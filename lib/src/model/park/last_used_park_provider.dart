import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'park_enum.dart';

class LastUsedParkNotifier extends Notifier<ParkEnum?> {
  static const _prefsKey = 'lastUsedPark';

  @override
  ParkEnum? build() {
    _loadFromStorage();
    return null;
  }

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_prefsKey);
    if (stored == null) return;

    final park = ParkEnum.values.firstWhere((element) => element.name == stored, orElse: () => ParkEnum.essenGrugapark);
    state = park;
  }

  Future<void> loadFromStorage() => _loadFromStorage();

  Future<void> setPark(ParkEnum park) async {
    state = park;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, park.name);
  }

  Future<void> clear() async {
    state = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }
}

final lastUsedParkProvider = NotifierProvider<LastUsedParkNotifier, ParkEnum?>(LastUsedParkNotifier.new);
