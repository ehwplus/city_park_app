class OpeningHours {
  const OpeningHours({
    required this.season,
    required this.openingTimeType,
    this.specifier,
    this.note,
    required this.openingTime,
  });

  final Season season;
  final OpeningTimeType openingTimeType;
  final String? specifier;
  final String? note;
  final TimeRange? openingTime;
}

class Season {
  const Season({required this.start, required this.end});

  final DateTime start;
  final DateTime end;
}

class TimeRange {
  const TimeRange({
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
    this.weekdays = const [
      DateTime.monday,
      DateTime.tuesday,
      DateTime.wednesday,
      DateTime.thursday,
      DateTime.friday,
      DateTime.saturday,
      DateTime.sunday,
    ],
  });

  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;
  final List<int> weekdays;

  String formatTime(int hour, int minute) =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  String get formattedStart => formatTime(startHour, startMinute);
  String get formattedEnd => formatTime(endHour, endMinute);
}

enum OpeningTimeType { dailyTicket, annualPass, ticketOffice, other }