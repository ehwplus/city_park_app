class Date {
  const Date({required this.month, required this.day, this.year});

  final int month;
  final int day;
  final int? year;

  DateTime resolve({DateTime? reference}) {
    final referenceDate = reference ?? DateTime.now();

    if (year != null) {
      return DateTime(year!, month, day);
    }

    final candidate = DateTime(referenceDate.year, month, day);
    if (candidate.isBefore(referenceDate)) {
      return candidate;
    }

    return DateTime(referenceDate.year + 1, month, day);
  }
}
