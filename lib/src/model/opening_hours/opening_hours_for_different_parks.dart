import 'package:city_park_app/src/model/opening_hours/date.dart';
import 'package:city_park_app/src/model/opening_hours/opening_hours.dart';

final openingHoursWestfalenpark = [
  OpeningHours(
    season: Season(start: Date(month: 1, day: 1), end: Date(month: 12, day: 31)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 9, endHour: 21),
  ),
];

final openingHoursDortmundZoo = [
  OpeningHours(
    season: Season(start: Date(month: 11, day: 1), end: Date(month: 2, day: 29)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 9, endHour: 16, endMinute: 30),
  ),
  OpeningHours(
    season: Season(start: Date(month: 3, day: 1), end: Date(month: 3, day: 31)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 9, endHour: 17, endMinute: 30),
  ),
  OpeningHours(
    season: Season(start: Date(month: 10, day: 1), end: Date(month: 10, day: 31)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 9, endHour: 17, endMinute: 30),
  ),
  OpeningHours(
    season: Season(start: Date(month: 4, day: 1), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 9, endHour: 18, endMinute: 30),
  ),
];

final openingHoursGrugapark = [
  OpeningHours(
    season: Season(start: Date(month: 1, day: 1), end: Date(month: 12, day: 30)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 7, startMinute: 30, endHour: 16),
  ),
  OpeningHours(
    season: Season(start: Date(month: 1, day: 1), end: Date(month: 12, day: 31)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 7, startMinute: 30, endHour: 23, endMinute: 00),
  ),
  OpeningHours(
    season: Season(start: Date(month: 12, day: 31), end: Date(month: 12, day: 30)),
    openingTimeType: OpeningTimeType.annualPass,
    openingTime: TimeRange(startHour: 7, startMinute: 30, endHour: 23, endMinute: 00),
  ),
  OpeningHours(
    season: Season(start: Date(month: 1, day: 1), end: Date(month: 12, day: 31)),
    openingTimeType: OpeningTimeType.annualPass,
    openingTime: TimeRange(startHour: 7, startMinute: 30, endHour: 23, endMinute: 00),
  ),
  OpeningHours(
    season: Season(start: Date(month: 4, day: 1), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.other,
    specifier: 'Kleintiergarten und Bauernhof',
    openingTime: TimeRange(startHour: 11, startMinute: 0, endHour: 18, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 3, day: 30), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.other,
    specifier: 'Grugabahn',
    note: '''
Die Grugabahn fährt während der Sommersaison täglich von 11 bis 18 Uhr. Die Betriebszeit startet am 3ß.3. Bei schlechtem Wetter finden keine Fahrten statt! Nach Ende der Herbstferien, spätestens aber während der Gültigkeit der ermäßigten Eintrittspreise in der Wintersaison, hat die Grugabahn Betriebspause. Info-Tel.: 0201 - 88 83 106. Die Fahrkarten kosten 5,- Euro für Erwachsene und 2,- Euro für Kinder und Jugendliche im Alter von 4 bis 15 Jahren.
    ''',
    openingTime: TimeRange(startHour: 11, startMinute: 0, endHour: 18, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 3, day: 30), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.other,
    specifier: 'Vogelfreifluganlage',
    openingTime: TimeRange(startHour: 11, startMinute: 0, endHour: 18, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 3, day: 30), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.other,
    specifier: 'Pflanzenschauhäuser',
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 19, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 3, day: 30), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.other,
    specifier: 'Spielhaus',
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 19, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 3, day: 30), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.other,
    specifier: 'Damwildgehege',
    note: '''
Ganzjährig (Di bis So), außer in der Brunftzeit

Der Kontaktbereich kann nur geöffnet werden, wenn eine Betreuung vor Ort durch Ehrenamtliche sichergestellt ist. Dies ist täglich außer montags von ca. 14 bis 17 Uhr der Fall. Bei schlechtem Wetter sind Ausnahmen möglich. Tagesaktuelle Informationen unter Tel. 0201 - 88 83 106

Das Damwildgehege ist während der Brunftzeit der Hirsche geschlossen. Die Brunftzeit dauert je nach Witterungsverlauf etwa von Anfang Oktober bis Ende November.
    ''',
    openingTime: TimeRange(
      startHour: 14,
      startMinute: 0,
      endHour: 17,
      endMinute: 0,
      weekdays: const [
        DateTime.tuesday,
        DateTime.wednesday,
        DateTime.thursday,
        DateTime.friday,
        DateTime.saturday,
        DateTime.sunday,
      ],
    ),
  ),
];

final openingHoursLuisenpark = [
  OpeningHours(
    season: Season(start: Date(month: 3, day: 1), end: Date(month: 4, day: 30)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 18, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 5, day: 1), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 19, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 10, day: 1), end: Date(month: 10, day: 31)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 18, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 11, day: 1), end: Date(month: 2, day: 28)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 16, endMinute: 0),
  ),

  /// Annual Pass
  OpeningHours(
    season: Season(start: Date(month: 3, day: 1), end: Date(month: 4, day: 30)),
    openingTimeType: OpeningTimeType.annualPass,
    openingTime: TimeRange(startHour: 8, startMinute: 0, endHour: 19, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 11, day: 1), end: Date(month: 2, day: 28)),
    openingTimeType: OpeningTimeType.annualPass,
    openingTime: TimeRange(startHour: 8, startMinute: 0, endHour: 17, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 5, day: 1), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.annualPass,
    openingTime: TimeRange(startHour: 8, startMinute: 0, endHour: 20, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 10, day: 1), end: Date(month: 10, day: 31)),
    openingTimeType: OpeningTimeType.annualPass,
    openingTime: TimeRange(startHour: 8, startMinute: 0, endHour: 19, endMinute: 0),
  ),

  /// Ticket Office
  OpeningHours(
    season: Season(start: Date(month: 3, day: 1), end: Date(month: 3, day: 31)),
    openingTimeType: OpeningTimeType.ticketOffice,
    openingTime: TimeRange(startHour: 10, startMinute: 0, endHour: 17, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 4, day: 1), end: Date(month: 8, day: 31)),
    openingTimeType: OpeningTimeType.ticketOffice,
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 18, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 9, day: 1), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.ticketOffice,
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 17, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 10, day: 1), end: Date(month: 10, day: 31)),
    openingTimeType: OpeningTimeType.ticketOffice,
    openingTime: TimeRange(startHour: 10, startMinute: 0, endHour: 17, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 11, day: 1), end: Date(month: 2, day: 28)),
    openingTimeType: OpeningTimeType.ticketOffice,
    openingTime: TimeRange(startHour: 10, startMinute: 0, endHour: 16, endMinute: 0),
  ),

  /// UNTERWASSERWELT
  OpeningHours(
    season: Season(start: Date(month: 3, day: 1), end: Date(month: 4, day: 30)),
    openingTimeType: OpeningTimeType.other,
    specifier: 'UNTERWASSERWELT',
    openingTime: TimeRange(startHour: 10, startMinute: 0, endHour: 17, endMinute: 30),
  ),
  OpeningHours(
    season: Season(start: Date(month: 5, day: 1), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.other,
    specifier: 'UNTERWASSERWELT',
    openingTime: TimeRange(startHour: 10, startMinute: 0, endHour: 18, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 11, day: 1), end: Date(month: 2, day: 28)),
    openingTimeType: OpeningTimeType.other,
    specifier: 'UNTERWASSERWELT',
    openingTime: TimeRange(startHour: 10, startMinute: 0, endHour: 16, endMinute: 30),
  ),
];

final openingHoursHerzogenriedpark = [
  OpeningHours(
    season: Season(start: Date(month: 3, day: 1), end: Date(month: 4, day: 30)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 18, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 5, day: 1), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 19, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 10, day: 1), end: Date(month: 10, day: 31)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 18, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 11, day: 1), end: Date(month: 2, day: 28)),
    openingTimeType: OpeningTimeType.dailyTicket,
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 16, endMinute: 0),
  ),

  /// Annual Pass
  OpeningHours(
    season: Season(start: Date(month: 3, day: 1), end: Date(month: 4, day: 30)),
    openingTimeType: OpeningTimeType.annualPass,
    openingTime: TimeRange(startHour: 8, startMinute: 0, endHour: 19, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 11, day: 1), end: Date(month: 2, day: 28)),
    openingTimeType: OpeningTimeType.annualPass,
    openingTime: TimeRange(startHour: 8, startMinute: 0, endHour: 17, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 5, day: 1), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.annualPass,
    openingTime: TimeRange(startHour: 8, startMinute: 0, endHour: 20, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 10, day: 1), end: Date(month: 10, day: 31)),
    openingTimeType: OpeningTimeType.annualPass,
    openingTime: TimeRange(startHour: 8, startMinute: 0, endHour: 19, endMinute: 0),
  ),

  /// Ticket Office
  OpeningHours(
    season: Season(start: Date(month: 3, day: 1), end: Date(month: 4, day: 30)),
    openingTimeType: OpeningTimeType.ticketOffice,
    openingTime: TimeRange(startHour: 10, startMinute: 0, endHour: 17, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 5, day: 1), end: Date(month: 6, day: 30)),
    openingTimeType: OpeningTimeType.ticketOffice,
    openingTime: TimeRange(startHour: 10, startMinute: 0, endHour: 18, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 7, day: 1), end: Date(month: 8, day: 31)),
    openingTimeType: OpeningTimeType.ticketOffice,
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 18, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 9, day: 1), end: Date(month: 9, day: 30)),
    openingTimeType: OpeningTimeType.ticketOffice,
    openingTime: TimeRange(startHour: 9, startMinute: 0, endHour: 17, endMinute: 0),
  ),
  OpeningHours(
    season: Season(start: Date(month: 11, day: 1), end: Date(month: 2, day: 28)),
    openingTimeType: OpeningTimeType.ticketOffice,
    openingTime: null,
  ),
];
