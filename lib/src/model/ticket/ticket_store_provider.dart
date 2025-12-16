import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../park/park_enum.dart';
import 'ticket_model.dart';

/// Riverpod store for managing saved tickets with persistence.
class TicketStore extends Notifier<List<TicketModel>> {
  static const _prefsKey = 'tickets';

  @override
  List<TicketModel> build() {
    _loadFromStorage();
    return const [];
  }

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_prefsKey);
    if (stored == null || stored.isEmpty) {
      return;
    }

    final List<dynamic> decoded = jsonDecode(stored) as List<dynamic>;
    final tickets = decoded.map((item) => _ticketFromMap(Map<String, dynamic>.from(item))).toList();
    state = tickets;
  }

  Future<void> loadFromStorage() => _loadFromStorage();

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(state.map(_ticketToMap).toList());
    await prefs.setString(_prefsKey, encoded);
  }

  Future<void> add(TicketModel ticket) async {
    state = [...state, ticket];
    await _persist();
  }

  Future<void> upsert(TicketModel ticket) async {
    final index = state.indexWhere((existing) => existing.uuid == ticket.uuid);
    if (index == -1) {
      await add(ticket);
      return;
    }
    final updated = [...state];
    updated[index] = ticket;
    state = updated;
    await _persist();
  }

  Future<void> removeById(String uuid) async {
    state = state.where((ticket) => ticket.uuid != uuid).toList();
    await _persist();
  }

  Future<void> clear() async {
    state = const [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }
}

Map<String, dynamic> _ticketToMap(TicketModel ticket) {
  return {
    'uuid': ticket.uuid,
    'firstName': ticket.firstName,
    'lastName': ticket.lastName,
    'birthday': ticket.birthday?.toIso8601String(),
    'qrCode': ticket.qrCode,
    'cardNumber': ticket.cardNumber,
    'parks': ticket.parks.map((park) => park.name).toList(),
  };
}

TicketModel _ticketFromMap(Map<String, dynamic> json) {
  final parks =
      (json['parks'] as List<dynamic>? ?? [])
          .map((park) => park.toString())
          .map(
            (parkName) =>
                ParkEnum.values.firstWhere((park) => park.name == parkName, orElse: () => ParkEnum.EssenGrugapark),
          )
          .toList();

  DateTime? birthday;
  final birthdayRaw = json['birthday'];
  if (birthdayRaw is String && birthdayRaw.isNotEmpty) {
    birthday = DateTime.tryParse(birthdayRaw);
  }

  return TicketModel(
    uuid: json['uuid'] as String,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    birthday: birthday,
    qrCode: json['qrCode'] as String?,
    cardNumber: json['cardNumber'] as String?,
    parks: parks,
  );
}

final ticketStoreProvider = NotifierProvider<TicketStore, List<TicketModel>>(TicketStore.new);
