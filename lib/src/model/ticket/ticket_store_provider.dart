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
  return ticket.toJson();
}

TicketModel _ticketFromMap(Map<String, dynamic> json) {
  return TicketModel.fromJson(json);
}

final ticketStoreProvider = NotifierProvider<TicketStore, List<TicketModel>>(TicketStore.new);
