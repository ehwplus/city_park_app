import 'dart:ui';

import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:city_park_app/src/model/ticket/ticket_model.dart';

Color resolveTicketBackgroundColor({required ParkEnum park, required TicketModel ticket}) {
  if (ticket.type == TicketType.ruhrTopCard) {
    return Color(0xFF017eb8);
  }

  return Color(park.primaryColor);
}
