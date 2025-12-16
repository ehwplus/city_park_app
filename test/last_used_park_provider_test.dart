import 'package:city_park_app/src/model/park/last_used_park_provider.dart';
import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LastUsedParkNotifier', () {
    late ProviderContainer container;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('defaults to null', () {
      expect(container.read(lastUsedParkProvider), isNull);
    });

    test('setPark updates the state', () async {
      await container.read(lastUsedParkProvider.notifier).setPark(ParkEnum.EssenGrugapark);

      expect(container.read(lastUsedParkProvider), ParkEnum.EssenGrugapark);
    });

    test('clear resets the state to null', () async {
      final notifier = container.read(lastUsedParkProvider.notifier);
      await notifier.setPark(ParkEnum.DortmundWestfalenpark);

      await notifier.clear();

      expect(container.read(lastUsedParkProvider), isNull);
    });

    test('persists last park across reload', () async {
      await container.read(lastUsedParkProvider.notifier).setPark(ParkEnum.MannheimHerzogenriedpark);

      final secondContainer = ProviderContainer();
      await secondContainer.read(lastUsedParkProvider.notifier).loadFromStorage();

      expect(secondContainer.read(lastUsedParkProvider), ParkEnum.MannheimHerzogenriedpark);
      secondContainer.dispose();
    });
  });
}
