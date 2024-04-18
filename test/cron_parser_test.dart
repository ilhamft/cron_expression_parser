import 'package:test/test.dart';

import 'package:cron_parser/cron_parser.dart';

void main() {
  group('Cron().parse()', () {
    test('Cron.parse() throws exception on empty cron string', () {
      expect(
        () => Cron.parse(''),
        throwsA(TypeMatcher<FormatException>()),
      );
    });

    test('Cron.parse() can parse 5-field expression', () {
      expect(
        Cron.parse('* * * * *'),
        TypeMatcher<Cron>(),
      );
    });

    test('Cron.parse() can parse 6-field expression', () {
      expect(
        Cron.parse('* * * * * *'),
        TypeMatcher<Cron>(),
      );
    });

    test('Cron.parse() throws exception on expression with too few fields', () {
      expect(
        () => Cron.parse('* * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
    });

    test('Cron.parse() throws exception on expression with too many fields',
        () {
      expect(
        () => Cron.parse('* * * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
    });

    test('Cron.parse() can parse tab separated expression', () {
      expect(
        Cron.parse('*\t*\t * *\t *'),
        TypeMatcher<Cron>(),
      );
    });

    test('Cron.parse() throws exception on out of range value', () {
      expect(
        () => Cron.parse('-1 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('61 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* -1 * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* 61 * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * -1 * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * 25 * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * 0 * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * 32 * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * 0 *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * 13 *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * -1'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * 8'),
        throwsA(TypeMatcher<FormatException>()),
      );
    });

    test('Cron.parse() throws exception on out of range list value', () {
      expect(
        () => Cron.parse('30,61 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('-1,30 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* 30,61 * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* -1,30 * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * 12,25 * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * -1,12 * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * 15,32 * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * 0,15 * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * 6,13 *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * 0,6 *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * 4,8'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * -1,4'),
        throwsA(TypeMatcher<FormatException>()),
      );
    });

    test('Cron.parse() throws exception on out of range repeat value', () {
      expect(
        () => Cron.parse('0/0 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('0/-1 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('-1/2 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('61/2 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* -1/2 * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* 61/2 * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * -1/2 * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * 25/2 * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * 0/2 * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * 32/2 * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * 0/2 *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * 13/2 *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * -1/2'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * 8/2'),
        throwsA(TypeMatcher<FormatException>()),
      );
    });

    test('Cron.parse() throws exception on out of range ranged value', () {
      expect(
        () => Cron.parse('-1,30 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('30,61 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* -1,30 * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* 30,61 * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * -1,12 * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * 12,25 * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * 0,15 * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * 15,32 * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * 0,6 *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * 6,13 *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * -1,4'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * 4,8'),
        throwsA(TypeMatcher<FormatException>()),
      );
    });

    test('Cron.parse() throws exception on out of range nth weekday value', () {
      expect(
        () => Cron.parse('* * * * * 1#0'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * 1#6'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * -1#2'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * 8#2'),
        throwsA(TypeMatcher<FormatException>()),
      );
    });

    test('Cron.parse() throws exception on out of range last weekday value',
        () {
      expect(
        () => Cron.parse('* * * * * -1L'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * 8L'),
        throwsA(TypeMatcher<FormatException>()),
      );
    });

    test('Cron.parse() throws exception on invalid format', () {
      expect(
        () => Cron.parse(', * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('/ * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('1/2/3 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('- * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('1-2-3 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('3-2 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('1-2-3/4 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('1-2/3-4 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('1/2-3 * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * #'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * 1#2#3'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * L'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * L1'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * * * * 2L1'),
        throwsA(TypeMatcher<FormatException>()),
      );
    });

    test('Cron.parse() throws exception on invalid characters', () {
      expect(
        () => Cron.parse('! * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('x * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('L * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('( * * * * *'),
        throwsA(TypeMatcher<FormatException>()),
      );
    });
  });

  group('.next()', () {
    test('.next() throws exception on invalid cron string', () {
      expect(
        () => Cron.parse('* * 31 2 *').next(),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('1/60 * * * *').next(),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * 29 2 *').next(),
        throwsA(TypeMatcher<FormatException>()),
      );
      expect(
        () => Cron.parse('* * 29 2 *').next(),
        throwsA(TypeMatcher<FormatException>()),
      );
    });

    test('.next() handle leap year correctly', () {
      expect(
        Cron.parse('* * 29 2 *').next(DateTime.parse('2024-01-01T00Z')),
        DateTime.parse('2024-02-29T00Z'),
      );
      expect(
        Cron.parse('* * 29 2 *').next(DateTime.parse('2024-03-01T00Z')),
        DateTime.parse('2028-02-29T00Z'),
      );
      expect(
        Cron.parse('* * 29 2 *').next(DateTime.parse('2100-01-01T00Z')),
        DateTime.parse('2104-02-29T00Z'),
      );
    });

    test('.next() handle cron with default value correctly', () {
      expect(
        Cron.parse('* * * * * *').next(DateTime.parse('2024-01-01T00:00:00Z')),
        DateTime.parse('2024-01-01T00:00:00Z'),
      );
      expect(
        Cron.parse('* * * * *').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-01T00:01:00Z'),
      );
    });

    test('.next() handle cron with second field correctly', () {
      expect(
        Cron.parse('0 * * * * *').next(DateTime.parse('2024-01-01T00:00:00Z')),
        DateTime.parse('2024-01-01T00:00:00Z'),
      );
      expect(
        Cron.parse('30 * * * * *').next(DateTime.parse('2024-01-01T00:00:00Z')),
        DateTime.parse('2024-01-01T00:00:30Z'),
      );
    });

    test('.next() handle cron with minute field correctly', () {
      expect(
        Cron.parse('0 * * * *').next(DateTime.parse('2024-01-01T00:00:00Z')),
        DateTime.parse('2024-01-01T00:00:00Z'),
      );
      expect(
        Cron.parse('0 * * * *').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-01T01:00:00Z'),
      );
      expect(
        Cron.parse('30 * * * *').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-01T00:30:00Z'),
      );
    });

    test('.next() handle cron with hour field correctly', () {
      expect(
        Cron.parse('* 0 * * *').next(DateTime.parse('2024-01-01T00:00:00Z')),
        DateTime.parse('2024-01-01T00:00:00Z'),
      );
      expect(
        Cron.parse('* 0 * * *').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-01T00:01:00Z'),
      );
      expect(
        Cron.parse('* 12 * * *').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-01T12:00:00Z'),
      );
      expect(
        Cron.parse('0 0 * * *').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-02T00:00:00Z'),
      );
    });

    test('.next() handle cron with day field correctly', () {
      expect(
        Cron.parse('* * 1 * *').next(DateTime.parse('2024-01-01T00:00:00Z')),
        DateTime.parse('2024-01-01T00:00:00Z'),
      );
      expect(
        Cron.parse('* * 1 * *').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-01T00:01:00Z'),
      );
      expect(
        Cron.parse('* * 15 * *').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-15T00:00:00Z'),
      );
      expect(
        Cron.parse('0 0 1 * *').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-02-01T00:00:00Z'),
      );
    });

    test('.next() handle cron with month field correctly', () {
      expect(
        Cron.parse('* * * 1 *').next(DateTime.parse('2024-01-01T00:00:00Z')),
        DateTime.parse('2024-01-01T00:00:00Z'),
      );
      expect(
        Cron.parse('* * * 1 *').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-01T00:01:00Z'),
      );
      expect(
        Cron.parse('* * * 6 *').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-06-01T00:00:00Z'),
      );
      expect(
        Cron.parse('0 0 1 1 *').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2025-01-01T00:00:00Z'),
      );
    });

    test('.next() handle cron with weekday field correctly', () {
      expect(
        Cron.parse('* * * * 1').next(DateTime.parse('2024-01-01T00:00:00Z')),
        DateTime.parse('2024-01-01T00:00:00Z'),
      );
      expect(
        Cron.parse('* * * * 0').next(DateTime.parse('2024-01-01T00:00:00Z')),
        DateTime.parse('2024-01-07T00:00:00Z'),
      );
      expect(
        Cron.parse('* * * * 7').next(DateTime.parse('2024-01-01T00:00:00Z')),
        DateTime.parse('2024-01-07T00:00:00Z'),
      );
      expect(
        Cron.parse('* * * * 1').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-01T00:01:00Z'),
      );
      expect(
        Cron.parse('* * * * 4').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-04T00:00:00Z'),
      );
      expect(
        Cron.parse('0 0 * * 1').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-08T00:00:00Z'),
      );
    });
  });
}
