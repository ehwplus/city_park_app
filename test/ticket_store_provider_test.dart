import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:city_park_app/src/model/ticket/ticket_model.dart';
import 'package:city_park_app/src/model/ticket/ticket_store_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('TicketStore', () {
    late ProviderContainer container;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    TicketModel buildTicket({
      required String uuid,
      String? cardNumber,
      List<ParkEnum> parks = const [ParkEnum.essenGrugapark],
    }) {
      return TicketModel(
        uuid: uuid,
        firstName: 'Max',
        lastName: 'Mustermann',
        birthday: DateTime(1990, 1, 1),
        qrCode: 'qr-$uuid',
        cardNumber: cardNumber,
        parks: parks,
        type: TicketType.seasonPass,
      );
    }

    test('stores and reads tickets', () async {
      final ticket = buildTicket(uuid: '1');

      expect(container.read(ticketStoreProvider), isEmpty);

      await container.read(ticketStoreProvider.notifier).add(ticket);

      final stored = container.read(ticketStoreProvider);
      expect(stored, hasLength(1));
      expect(stored.single.uuid, ticket.uuid);
    });

    test('upsert replaces ticket with same uuid', () async {
      final original = buildTicket(uuid: '2', cardNumber: 'old');
      final updated = buildTicket(uuid: '2', cardNumber: 'new');

      await container.read(ticketStoreProvider.notifier).add(original);
      await container.read(ticketStoreProvider.notifier).upsert(updated);

      final stored = container.read(ticketStoreProvider);
      expect(stored, hasLength(1));
      expect(stored.single.cardNumber, 'new');
    });

    test('removeById removes the ticket', () async {
      final ticketA = buildTicket(uuid: '3');
      final ticketB = buildTicket(uuid: '4');

      final notifier = container.read(ticketStoreProvider.notifier);
      await notifier.add(ticketA);
      await notifier.add(ticketB);

      await notifier.removeById('3');

      final stored = container.read(ticketStoreProvider);
      expect(stored, hasLength(1));
      expect(stored.single.uuid, '4');
    });

    test('clear empties the store', () async {
      final notifier = container.read(ticketStoreProvider.notifier);
      await notifier.add(buildTicket(uuid: '5'));

      await notifier.clear();

      expect(container.read(ticketStoreProvider), isEmpty);
    });

    test('persists tickets across reload', () async {
      final ticket = buildTicket(uuid: 'persist');
      await container.read(ticketStoreProvider.notifier).add(ticket);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('tickets'), isNotNull);

      final secondContainer = ProviderContainer();
      await secondContainer.read(ticketStoreProvider.notifier).loadFromStorage();

      final reloaded = secondContainer.read(ticketStoreProvider);
      expect(reloaded, hasLength(1));
      expect(reloaded.single.uuid, ticket.uuid);
      secondContainer.dispose();
    });
  });
}
