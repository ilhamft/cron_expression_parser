library cron_parser;

final _standardRegex = RegExp(r'^[,*\d/-]+$');
final _dayRegex = RegExp(r'^[?,*\dL/-]+$');
final _weekdayRegex = RegExp(r'^[?,*\dL#/-]+$');

final _minuteDefaultValue = List.generate(60, (i) => i);
final _hourDefaultValue = List.generate(24, (i) => i);
final _dayDefaultValue = List.generate(31, (i) => i + 1);
final _monthDefaultValue = List.generate(12, (i) => i + 1);
final _weekdayDefaultValue = List.generate(7, (i) => i);

List<int> _parseMinute(String value) {
  if (!_standardRegex.hasMatch(value)) {
    throw FormatException('Invalid characters on $value');
  }
  if (value == '*' || value == '?') return _minuteDefaultValue;
  return _parseList(value, 0, 59);
}

List<int> _parseHour(String value) {
  if (!_standardRegex.hasMatch(value)) {
    throw FormatException('Invalid characters on $value');
  }
  if (value == '*' || value == '?') return _hourDefaultValue;
  return _parseList(value, 0, 23);
}

List<int> _parseDay(String value) {
  if (!_dayRegex.hasMatch(value)) {
    throw FormatException('Invalid characters on $value');
  }
  if (value == '*' || value == '?') return _dayDefaultValue;
  if (value == 'L') return [];
  return _parseList(value, 1, 31);
}

List<int> _parseMonth(String value) {
  // TODO Convert alias
  if (!_standardRegex.hasMatch(value)) {
    throw FormatException('Invalid characters on $value');
  }
  if (value == '*' || value == '?') return _monthDefaultValue;
  return _parseList(value, 1, 12);
}

List<int> _parseWeekday(String value) {
  // TODO Convert alias
  if (!_weekdayRegex.hasMatch(value)) {
    throw FormatException('Invalid characters on $value');
  }
  if (value == '*' || value == '?') return _weekdayDefaultValue;
  value.replaceAll('L', '');
  final cleanedValue = value.split('#');
  final list = _parseList(cleanedValue.first, 0, 7);
  // Replace 0 with 7
  if (list.contains(0)) {
    list.remove(0);
    if (!list.contains(7)) list.add(7);
    list.sort();
  }
  return list;
}

List<int> _parseList(String value, int minValue, int maxValue) {
  final values = value.split(',');
  if (values.contains('') || values.length == 0) {
    throw FormatException('Invalid list format on $value');
  }
  final List<int> list = values
      .map(
        (e) => _parseRepeat(e, minValue, maxValue),
      )
      .toList()
      .fold(
    [],
    (prev, e) {
      prev.addAll(e);
      return prev;
    },
  );
  list.sort();
  return list;
}

List<int> _parseRepeat(String value, int minValue, int maxValue) {
  final values = value.split('/');
  var rangeValue = values.first;
  if (values.contains('') || values.length > 2 || values.length == 0) {
    throw FormatException('Invalid repeat format on $value');
  }
  if (values.length == 1) {
    return _parseRange(value, 1, minValue, maxValue);
  }
  final repeatInterval = int.parse(values.last);
  if (repeatInterval < 1) {
    throw FormatException('Invalid repeat format on $value');
  }
  if (int.tryParse(values.first) != null) {
    rangeValue = '${values.first}-$maxValue';
  }
  return _parseRange(rangeValue, repeatInterval, minValue, maxValue);
}

List<int> _parseRange(
    String value, int repeatInterval, int minValue, int maxValue) {
  var values = value.split('-');
  if (values.contains('') || values.length > 2 || values.length == 0) {
    throw FormatException('Invalid range format on $value');
  }
  final min = int.parse(values.first);
  final max = int.parse(values.last);
  if (min < minValue || max > maxValue || min > max) {
    throw FormatException('Invalid range format on $value');
  }
  if (values.length == 1) return [int.parse(value)];
  final List<int> list = [];
  for (var i = min; i <= max; i = i + repeatInterval) {
    list.add(i);
  }
  return list;
}

bool _parseLastDayOfMonth(String value) {
  return value == 'L' ? true : false;
}

bool _parseLastWeekdayOfMonth(String value) {
  return value.contains('L') ? true : false;
}

int? _parseNthWeekday(String value) {
  if (!value.contains('#')) return null;
  if (value.contains(',') || value.contains('/') || value.contains('-')) {
    throw FormatException('Invalid day of week format on $value');
  }
  final values = value.split('#');
  if (values.contains('') || values.length != 2) {
    throw FormatException('Invalid day of week format on $value');
  }
  final nthValue = int.parse(values.last);
  if (nthValue < 1 || nthValue > 5) {
    throw FormatException('Invalid day of week format on $value');
  }
  return nthValue;
}

bool _isSecondMatch(Cron cron, DateTime dateTime) {
  return cron._second.contains(dateTime.second);
}

bool _isMinuteMatch(Cron cron, DateTime dateTime) {
  return cron._minute.contains(dateTime.minute);
}

bool _isHourMatch(Cron cron, DateTime dateTime) {
  return cron._hour.contains(dateTime.hour);
}

bool _isMonthMatch(Cron cron, DateTime dateTime) {
  return cron._month.contains(dateTime.month);
}

bool _isDayMatch(Cron cron, DateTime dateTime) {
  var result = cron._day.contains(dateTime.day);
  if (cron._lastDayOfMonth) {
    final isLastDayOfMonth =
        dateTime.add(const Duration(days: 1)).month != dateTime.month;
    result = isLastDayOfMonth;
  }
  return result;
}

bool _isWeekdayMatch(Cron cron, DateTime dateTime) {
  var result = cron._weekday.contains(dateTime.weekday);
  if (cron._lastWeekdayOfMonth) {
    final islastWeekdayOfMonth =
        dateTime.add(const Duration(days: 7)).month != dateTime.month;
    result = islastWeekdayOfMonth ? result : false;
  }
  if (cron._nthWeekday != null) {
    final isNthWeekday = (dateTime
                .subtract(Duration(days: 7 * cron._nthWeekday))
                .month !=
            dateTime.month) &&
        (dateTime.subtract(Duration(days: 7 * (cron._nthWeekday - 1))).month ==
            dateTime.month);
    result = isNthWeekday ? result : false;
  }
  return result;
}

class Cron {
  static const bool isUtc = true;

  late final List<int> _second;
  late final List<int> _minute;
  late final List<int> _hour;
  late final List<int> _day;
  late final List<int> _month;
  late final List<int> _weekday;
  late final bool _lastDayOfMonth;
  late final bool _lastWeekdayOfMonth;
  late final int? _nthWeekday;
  late final String _cronString;
  String toString() => _cronString;

  /// Constructs a new [Cron] instance based on [formattedString].
  ///
  /// Throws a [FormatException] if the input string cannot be parsed.
  Cron.parse(String formattedString) {
    _cronString = formattedString;
    List<String> values = formattedString.trim().split(RegExp(r'\s+'));

    if (values.length > 6 || values.length < 5) {
      throw FormatException('Unable to parse $formattedString');
    }
    if (values.length < 6) {
      values = [...List.filled(6 - values.length, '0'), ...values];
    }

    for (var i = 0; i < 6; i++) {
      final value = values[i];
      switch (i) {
        case 0:
          _second = _parseMinute(value);
          break;
        case 1:
          _minute = _parseMinute(value);
          break;
        case 2:
          _hour = _parseHour(value);
          break;
        case 3:
          _lastDayOfMonth = _parseLastDayOfMonth(value);
          _day = _parseDay(value);
          break;
        case 4:
          _month = _parseMonth(value);
          break;
        case 5:
          _lastWeekdayOfMonth = _parseLastWeekdayOfMonth(value);
          _nthWeekday = _parseNthWeekday(value);
          _weekday = _parseWeekday(value);
          break;
      }
    }
  }

  /// Returns [DateTime] of the next iteration after [from].
  ///
  /// If [from] is ommited the function will calculate
  /// the next iteration from current date and time.
  ///
  /// Returns [from] if it match the pattern.
  DateTime next([DateTime? from]) {
    from ??= DateTime.now();
    if (isUtc) from = from.toUtc();
    if (from.millisecond != 0) {
      from = from.add(Duration(milliseconds: 1000 - from.millisecond));
    }
    if (from.microsecond != 0) {
      from = from.add(Duration(microseconds: 1000 - from.microsecond));
    }
    const loopLimit = 10000;
    var stepCount = 0;
    var result = from;
    while (stepCount < loopLimit) {
      stepCount++;
      if (isMatch(result)) return result;
      var addedDuration = const Duration(seconds: 1);
      Duration? subtractedDuration;
      if (_isSecondMatch(this, result)) {
        addedDuration = Duration(seconds: 60 - result.second);
        if (_isMinuteMatch(this, result)) {
          addedDuration = Duration(minutes: 60 - result.minute);
          subtractedDuration = Duration(seconds: result.second);
          if (_isHourMatch(this, result)) {
            addedDuration = Duration(hours: 24 - result.hour);
            subtractedDuration =
                Duration(seconds: result.second, minutes: result.minute);
          }
        }
      }
      result = result.add(addedDuration);
      if (subtractedDuration != null)
        result = result.subtract(subtractedDuration);
    }
    throw FormatException('Invalid cron, failed to find next iteration');
  }

  /// Returns true if [dateTime] matches the pattern.
  bool isMatch(DateTime dateTime) {
    if (dateTime.millisecond != 0 || dateTime.microsecond != 0) return false;
    return _isSecondMatch(this, dateTime) &&
        _isMinuteMatch(this, dateTime) &&
        _isHourMatch(this, dateTime) &&
        _isMonthMatch(this, dateTime) &&
        _isDayMatch(this, dateTime) &&
        _isWeekdayMatch(this, dateTime);
  }
}
