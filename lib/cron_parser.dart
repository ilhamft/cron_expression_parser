library cron_parser;

final _standardRegex = RegExp(r'^[,*\d/-]+$');
final _dayOfMonthRegex = RegExp(r'^[?,*\dL/-]+$');
final _dayOfWeekRegex = RegExp(r'^[?,*\dL#/-]+$');

final _minuteDefaultValue = List.generate(60, (i) => i);
final _hourDefaultValue = List.generate(24, (i) => i);
final _dayOfMonthDefaultValue = List.generate(31, (i) => i + 1);
final _monthDefaultValue = List.generate(12, (i) => i + 1);
final _dayOfWeekDefaultValue = List.generate(7, (i) => i);

List<int> _parseMinute(String value) {
  if (!_standardRegex.hasMatch(value)) {
    throw 'Invalid characters on $value';
  }
  if (value == '*' || value == '?') return _minuteDefaultValue;
  return _parseList(value, 0, 59);
}

List<int> _parseHour(String value) {
  if (!_standardRegex.hasMatch(value)) {
    throw 'Invalid characters on $value';
  }
  if (value == '*' || value == '?') return _hourDefaultValue;
  return _parseList(value, 0, 23);
}

List<int> _parseDayOfMonth(String value) {
  if (!_dayOfMonthRegex.hasMatch(value)) {
    throw 'Invalid characters on $value';
  }
  if (value == '*' || value == '?') return _dayOfMonthDefaultValue;
  if (value == 'L') return [];
  return _parseList(value, 1, 31);
}

List<int> _parseMonth(String value) {
  if (!_standardRegex.hasMatch(value)) {
    throw 'Invalid characters on $value';
  }
  if (value == '*' || value == '?') return _monthDefaultValue;
  return _parseList(value, 1, 12);
}

List<int> _parseDayOfWeek(String value) {
  if (!_dayOfWeekRegex.hasMatch(value)) {
    throw 'Invalid characters on $value';
  }
  if (value == '*' || value == '?') return _dayOfWeekDefaultValue;
  value.replaceAll('L', '');
  final cleanedValue = value.split('#');
  final list = _parseList(cleanedValue.first, 0, 7);
  if (list.contains(7)) {
    list.remove(7);
    if (!list.contains(0)) list.add(0);
    list.sort();
  }
  return list;
}

List<int> _parseList(String value, int minValue, int maxValue) {
  final values = value.split(',');
  if (values.contains('')) throw 'Invalid list format on $value';
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
  final repeatInterval = int.parse(values.last);
  var rangeValue = values.first;
  if (values.contains('') || values.length > 2 || repeatInterval < 1) {
    throw 'Invalid repeat format on $value';
  }
  if (values.length == 1) return [int.parse(value)];
  if (int.tryParse(values.first) != null) {
    rangeValue = '${values.first}-$maxValue';
  }
  return _parseRange(rangeValue, repeatInterval, minValue, maxValue);
}

List<int> _parseRange(
    String value, int repeatInterval, int minValue, int maxValue) {
  var values = value.split('-');
  if (values.contains('') || values.length != 2) {
    throw 'Invalid range format on $value';
  }
  final min = int.parse(values.first);
  final max = int.parse(values.last);
  if (min < minValue || max > maxValue || min > max) {
    throw 'Invalid range format on $value';
  }
  final List<int> list = [];
  for (var i = min; i <= max; i + repeatInterval) {
    list.add(i);
  }
  return list;
}

bool _parseLastDayOfMonth(String value) {
  return value == 'L' ? true : false;
}

bool _parseLastWeekDayOfMonth(String value) {
  return value.contains('L') ? true : false;
}

int? _parseNthDayOfWeek(String value) {
  if (!value.contains('#')) return null;
  if (value.contains(',') || value.contains('/') || value.contains('-')) {
    throw 'Invalid day of week format on $value';
  }
  final values = value.split('#');
  if (values.contains('') || values.length != 2) {
    throw 'Invalid day of week format on $value';
  }
  final nthValue = int.parse(values.last);
  if (nthValue < 1 || nthValue > 5) {
    throw 'Invalid day of week format on $value';
  }
  return nthValue;
}

class Cron {
  late final List<int> _second;
  late final List<int> _minute;
  late final List<int> _hour;
  late final List<int> _dayOfMonth;
  late final List<int> _month;
  late final List<int> _dayOfWeek;
  late final bool _lastDayOfMonth;
  late final bool _lastWeekDayOfMonth;
  late final int? _nthDayOfWeek;

  Cron.parse(String formattedString) {
    List<String> values = formattedString.trim().split(RegExp(r'\s+'));

    if (values.length > 6 || values.length < 5) {
      throw 'Unable to parse $formattedString';
    }
    if (values.length < 6) {
      values = [...List.filled(6 - values.length, '0'), ...values];
    }

    for (var i = 0; i < 6; i++) {
      final value = values[i];
      if (i == 0) _second = _parseMinute(value);
      if (i == 1) _minute = _parseMinute(value);
      if (i == 2) _hour = _parseHour(value);
      if (i == 3) {
        _lastDayOfMonth = _parseLastDayOfMonth(value);
        _dayOfMonth = _parseDayOfMonth(value);
      }
      if (i == 4) _month = _parseMonth(value);
      if (i == 5) {
        _lastWeekDayOfMonth = _parseLastWeekDayOfMonth(value);
        _nthDayOfWeek = _parseNthDayOfWeek(value);
        _dayOfWeek = _parseDayOfWeek(value);
      }
    }
  }
}
