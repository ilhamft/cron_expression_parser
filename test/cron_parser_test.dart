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
      expect(
        Cron.parse('* * L * *').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-31T00:00:00Z'),
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
        Cron.parse('* * * * 1L').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-29T00:00:00Z'),
      );
      expect(
        Cron.parse('* * * * 0#3').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-21T00:00:00Z'),
      );
      expect(
        Cron.parse('0 0 * * 1').next(DateTime.parse('2024-01-01T00:00:30Z')),
        DateTime.parse('2024-01-08T00:00:00Z'),
      );
    });
  });

  group('.toList()', () {
    test('.toList() throws exception on invalid parameter', () {
      expect(
        () => Cron.parse('* * * * *')
            .toList(DateTime.parse('2024'), DateTime.parse('2023')),
        throwsA(TypeMatcher<FormatException>()),
      );
    });

    test('.toList() handle cron with default value correctly', () {
      expect(
        Cron.parse('* * * * * *').toList(
          DateTime.parse('2024-01-01T00:00:00Z'),
          DateTime.parse('2024-01-01T00:00:59Z'),
        ),
        List.generate(60, (i) => DateTime.utc(2024, 1, 1, 0, 0, i)),
      );
      expect(
        Cron.parse('* * * * *').toList(
          DateTime.parse('2024-01-01T00:00:00Z'),
          DateTime.parse('2024-01-01T00:59:59Z'),
        ),
        List.generate(60, (i) => DateTime.utc(2024, 1, 1, 0, i)),
      );
    });

    test('.toList() handle list in second field correctly', () {
      expect(
        Cron.parse('6,9,42 * * * * *').toList(
          DateTime.parse('2024-01-01T00:00:00Z'),
          DateTime.parse('2024-01-01T00:03:00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00:00:06Z'),
          DateTime.parse('2024-01-01T00:00:09Z'),
          DateTime.parse('2024-01-01T00:00:42Z'),
          DateTime.parse('2024-01-01T00:01:06Z'),
          DateTime.parse('2024-01-01T00:01:09Z'),
          DateTime.parse('2024-01-01T00:01:42Z'),
          DateTime.parse('2024-01-01T00:02:06Z'),
          DateTime.parse('2024-01-01T00:02:09Z'),
          DateTime.parse('2024-01-01T00:02:42Z'),
        ],
      );
    });

    test('.toList() handle repeat in second field correctly', () {
      expect(
        Cron.parse('55/2 * * * * *').toList(
          DateTime.parse('2024-01-01T00:00:00Z'),
          DateTime.parse('2024-01-01T00:03:00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00:00:55Z'),
          DateTime.parse('2024-01-01T00:00:57Z'),
          DateTime.parse('2024-01-01T00:00:59Z'),
          DateTime.parse('2024-01-01T00:01:55Z'),
          DateTime.parse('2024-01-01T00:01:57Z'),
          DateTime.parse('2024-01-01T00:01:59Z'),
          DateTime.parse('2024-01-01T00:02:55Z'),
          DateTime.parse('2024-01-01T00:02:57Z'),
          DateTime.parse('2024-01-01T00:02:59Z'),
        ],
      );
    });

    test('.toList() handle range in second field correctly', () {
      expect(
        Cron.parse('2-4 * * * * *').toList(
          DateTime.parse('2024-01-01T00:00:00Z'),
          DateTime.parse('2024-01-01T00:03:00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00:00:02Z'),
          DateTime.parse('2024-01-01T00:00:03Z'),
          DateTime.parse('2024-01-01T00:00:04Z'),
          DateTime.parse('2024-01-01T00:01:02Z'),
          DateTime.parse('2024-01-01T00:01:03Z'),
          DateTime.parse('2024-01-01T00:01:04Z'),
          DateTime.parse('2024-01-01T00:02:02Z'),
          DateTime.parse('2024-01-01T00:02:03Z'),
          DateTime.parse('2024-01-01T00:02:04Z'),
        ],
      );
    });

    test('.toList() handle repeat and range in second field correctly', () {
      expect(
        Cron.parse('24-42/5 * * * * *').toList(
          DateTime.parse('2024-01-01T00:00:00Z'),
          DateTime.parse('2024-01-01T00:03:00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00:00:24Z'),
          DateTime.parse('2024-01-01T00:00:29Z'),
          DateTime.parse('2024-01-01T00:00:34Z'),
          DateTime.parse('2024-01-01T00:00:39Z'),
          DateTime.parse('2024-01-01T00:01:24Z'),
          DateTime.parse('2024-01-01T00:01:29Z'),
          DateTime.parse('2024-01-01T00:01:34Z'),
          DateTime.parse('2024-01-01T00:01:39Z'),
          DateTime.parse('2024-01-01T00:02:24Z'),
          DateTime.parse('2024-01-01T00:02:29Z'),
          DateTime.parse('2024-01-01T00:02:34Z'),
          DateTime.parse('2024-01-01T00:02:39Z'),
        ],
      );
    });

    test('.toList() handle multiple format in second field correctly', () {
      expect(
        Cron.parse('0,1,23-45/6,7,8/9 * * * * *').toList(
          DateTime.parse('2024-01-01T00:00:00Z'),
          DateTime.parse('2024-01-01T00:03:00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00:00:00Z'),
          DateTime.parse('2024-01-01T00:00:01Z'),
          DateTime.parse('2024-01-01T00:00:07Z'),
          DateTime.parse('2024-01-01T00:00:08Z'),
          DateTime.parse('2024-01-01T00:00:17Z'),
          DateTime.parse('2024-01-01T00:00:23Z'),
          DateTime.parse('2024-01-01T00:00:26Z'),
          DateTime.parse('2024-01-01T00:00:29Z'),
          DateTime.parse('2024-01-01T00:00:35Z'),
          DateTime.parse('2024-01-01T00:00:41Z'),
          DateTime.parse('2024-01-01T00:00:44Z'),
          DateTime.parse('2024-01-01T00:00:53Z'),
          DateTime.parse('2024-01-01T00:01:00Z'),
          DateTime.parse('2024-01-01T00:01:01Z'),
          DateTime.parse('2024-01-01T00:01:07Z'),
          DateTime.parse('2024-01-01T00:01:08Z'),
          DateTime.parse('2024-01-01T00:01:17Z'),
          DateTime.parse('2024-01-01T00:01:23Z'),
          DateTime.parse('2024-01-01T00:01:26Z'),
          DateTime.parse('2024-01-01T00:01:29Z'),
          DateTime.parse('2024-01-01T00:01:35Z'),
          DateTime.parse('2024-01-01T00:01:41Z'),
          DateTime.parse('2024-01-01T00:01:44Z'),
          DateTime.parse('2024-01-01T00:01:53Z'),
          DateTime.parse('2024-01-01T00:02:00Z'),
          DateTime.parse('2024-01-01T00:02:01Z'),
          DateTime.parse('2024-01-01T00:02:07Z'),
          DateTime.parse('2024-01-01T00:02:08Z'),
          DateTime.parse('2024-01-01T00:02:17Z'),
          DateTime.parse('2024-01-01T00:02:23Z'),
          DateTime.parse('2024-01-01T00:02:26Z'),
          DateTime.parse('2024-01-01T00:02:29Z'),
          DateTime.parse('2024-01-01T00:02:35Z'),
          DateTime.parse('2024-01-01T00:02:41Z'),
          DateTime.parse('2024-01-01T00:02:44Z'),
          DateTime.parse('2024-01-01T00:02:53Z'),
          DateTime.parse('2024-01-01T00:03:00Z'),
        ],
      );
    });

    test('.toList() handle list in minute field correctly', () {
      expect(
        Cron.parse('6,9,42 * * * *').toList(
          DateTime.parse('2024-01-01T00:00Z'),
          DateTime.parse('2024-01-01T03:00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00:06Z'),
          DateTime.parse('2024-01-01T00:09Z'),
          DateTime.parse('2024-01-01T00:42Z'),
          DateTime.parse('2024-01-01T01:06Z'),
          DateTime.parse('2024-01-01T01:09Z'),
          DateTime.parse('2024-01-01T01:42Z'),
          DateTime.parse('2024-01-01T02:06Z'),
          DateTime.parse('2024-01-01T02:09Z'),
          DateTime.parse('2024-01-01T02:42Z'),
        ],
      );
    });

    test('.toList() handle repeat in minute field correctly', () {
      expect(
        Cron.parse('55/2 * * * *').toList(
          DateTime.parse('2024-01-01T00:00Z'),
          DateTime.parse('2024-01-01T03:00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00:55Z'),
          DateTime.parse('2024-01-01T00:57Z'),
          DateTime.parse('2024-01-01T00:59Z'),
          DateTime.parse('2024-01-01T01:55Z'),
          DateTime.parse('2024-01-01T01:57Z'),
          DateTime.parse('2024-01-01T01:59Z'),
          DateTime.parse('2024-01-01T02:55Z'),
          DateTime.parse('2024-01-01T02:57Z'),
          DateTime.parse('2024-01-01T02:59Z'),
        ],
      );
    });

    test('.toList() handle range in minute field correctly', () {
      expect(
        Cron.parse('2-4 * * * *').toList(
          DateTime.parse('2024-01-01T00:00Z'),
          DateTime.parse('2024-01-01T03:00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00:02Z'),
          DateTime.parse('2024-01-01T00:03Z'),
          DateTime.parse('2024-01-01T00:04Z'),
          DateTime.parse('2024-01-01T01:02Z'),
          DateTime.parse('2024-01-01T01:03Z'),
          DateTime.parse('2024-01-01T01:04Z'),
          DateTime.parse('2024-01-01T02:02Z'),
          DateTime.parse('2024-01-01T02:03Z'),
          DateTime.parse('2024-01-01T02:04Z'),
        ],
      );
    });

    test('.toList() handle repeat and range in minute field correctly', () {
      expect(
        Cron.parse('24-42/5 * * * *').toList(
          DateTime.parse('2024-01-01T00:00Z'),
          DateTime.parse('2024-01-01T03:00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00:24Z'),
          DateTime.parse('2024-01-01T00:29Z'),
          DateTime.parse('2024-01-01T00:34Z'),
          DateTime.parse('2024-01-01T00:39Z'),
          DateTime.parse('2024-01-01T01:24Z'),
          DateTime.parse('2024-01-01T01:29Z'),
          DateTime.parse('2024-01-01T01:34Z'),
          DateTime.parse('2024-01-01T01:39Z'),
          DateTime.parse('2024-01-01T02:24Z'),
          DateTime.parse('2024-01-01T02:29Z'),
          DateTime.parse('2024-01-01T02:34Z'),
          DateTime.parse('2024-01-01T02:39Z'),
        ],
      );
    });

    test('.toList() handle multiple format in minute field correctly', () {
      expect(
        Cron.parse('0,1,23-45/6,7,8/9 * * * *').toList(
          DateTime.parse('2024-01-01T00:00Z'),
          DateTime.parse('2024-01-01T03:00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00:00Z'),
          DateTime.parse('2024-01-01T00:01Z'),
          DateTime.parse('2024-01-01T00:07Z'),
          DateTime.parse('2024-01-01T00:08Z'),
          DateTime.parse('2024-01-01T00:17Z'),
          DateTime.parse('2024-01-01T00:23Z'),
          DateTime.parse('2024-01-01T00:26Z'),
          DateTime.parse('2024-01-01T00:29Z'),
          DateTime.parse('2024-01-01T00:35Z'),
          DateTime.parse('2024-01-01T00:41Z'),
          DateTime.parse('2024-01-01T00:44Z'),
          DateTime.parse('2024-01-01T00:53Z'),
          DateTime.parse('2024-01-01T01:00Z'),
          DateTime.parse('2024-01-01T01:01Z'),
          DateTime.parse('2024-01-01T01:07Z'),
          DateTime.parse('2024-01-01T01:08Z'),
          DateTime.parse('2024-01-01T01:17Z'),
          DateTime.parse('2024-01-01T01:23Z'),
          DateTime.parse('2024-01-01T01:26Z'),
          DateTime.parse('2024-01-01T01:29Z'),
          DateTime.parse('2024-01-01T01:35Z'),
          DateTime.parse('2024-01-01T01:41Z'),
          DateTime.parse('2024-01-01T01:44Z'),
          DateTime.parse('2024-01-01T01:53Z'),
          DateTime.parse('2024-01-01T02:00Z'),
          DateTime.parse('2024-01-01T02:01Z'),
          DateTime.parse('2024-01-01T02:07Z'),
          DateTime.parse('2024-01-01T02:08Z'),
          DateTime.parse('2024-01-01T02:17Z'),
          DateTime.parse('2024-01-01T02:23Z'),
          DateTime.parse('2024-01-01T02:26Z'),
          DateTime.parse('2024-01-01T02:29Z'),
          DateTime.parse('2024-01-01T02:35Z'),
          DateTime.parse('2024-01-01T02:41Z'),
          DateTime.parse('2024-01-01T02:44Z'),
          DateTime.parse('2024-01-01T02:53Z'),
          DateTime.parse('2024-01-01T03:00Z'),
        ],
      );
    });

    test('.toList() handle list in hour field correctly', () {
      expect(
        Cron.parse('0 6,9 * * *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-01-04T00Z'),
        ),
        [
          DateTime.parse('2024-01-01T06Z'),
          DateTime.parse('2024-01-01T09Z'),
          DateTime.parse('2024-01-02T06Z'),
          DateTime.parse('2024-01-02T09Z'),
          DateTime.parse('2024-01-03T06Z'),
          DateTime.parse('2024-01-03T09Z'),
        ],
      );
    });

    test('.toList() handle repeat in hour field correctly', () {
      expect(
        Cron.parse('0 20/2 * * *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-01-04T00Z'),
        ),
        [
          DateTime.parse('2024-01-01T20Z'),
          DateTime.parse('2024-01-01T22Z'),
          DateTime.parse('2024-01-02T20Z'),
          DateTime.parse('2024-01-02T22Z'),
          DateTime.parse('2024-01-03T20Z'),
          DateTime.parse('2024-01-03T22Z'),
        ],
      );
    });

    test('.toList() handle range in hour field correctly', () {
      expect(
        Cron.parse('0 2-4 * * *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-01-04T00Z'),
        ),
        [
          DateTime.parse('2024-01-01T02Z'),
          DateTime.parse('2024-01-01T03Z'),
          DateTime.parse('2024-01-01T04Z'),
          DateTime.parse('2024-01-02T02Z'),
          DateTime.parse('2024-01-02T03Z'),
          DateTime.parse('2024-01-02T04Z'),
          DateTime.parse('2024-01-03T02Z'),
          DateTime.parse('2024-01-03T03Z'),
          DateTime.parse('2024-01-03T04Z'),
        ],
      );
    });

    test('.toList() handle repeat and range in hour field correctly', () {
      expect(
        Cron.parse('0 3-18/5 * * *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-01-04T00Z'),
        ),
        [
          DateTime.parse('2024-01-01T03Z'),
          DateTime.parse('2024-01-01T08Z'),
          DateTime.parse('2024-01-01T13Z'),
          DateTime.parse('2024-01-01T18Z'),
          DateTime.parse('2024-01-02T03Z'),
          DateTime.parse('2024-01-02T08Z'),
          DateTime.parse('2024-01-02T13Z'),
          DateTime.parse('2024-01-02T18Z'),
          DateTime.parse('2024-01-03T03Z'),
          DateTime.parse('2024-01-03T08Z'),
          DateTime.parse('2024-01-03T13Z'),
          DateTime.parse('2024-01-03T18Z'),
        ],
      );
    });

    test('.toList() handle multiple format in hour field correctly', () {
      expect(
        Cron.parse('0 0,1,2-6/3,4,5/7 * * *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-01-04T00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-01-01T01Z'),
          DateTime.parse('2024-01-01T02Z'),
          DateTime.parse('2024-01-01T04Z'),
          DateTime.parse('2024-01-01T05Z'),
          DateTime.parse('2024-01-01T12Z'),
          DateTime.parse('2024-01-01T19Z'),
          DateTime.parse('2024-01-02T00Z'),
          DateTime.parse('2024-01-02T01Z'),
          DateTime.parse('2024-01-02T02Z'),
          DateTime.parse('2024-01-02T04Z'),
          DateTime.parse('2024-01-02T05Z'),
          DateTime.parse('2024-01-02T12Z'),
          DateTime.parse('2024-01-02T19Z'),
          DateTime.parse('2024-01-03T00Z'),
          DateTime.parse('2024-01-03T01Z'),
          DateTime.parse('2024-01-03T02Z'),
          DateTime.parse('2024-01-03T04Z'),
          DateTime.parse('2024-01-03T05Z'),
          DateTime.parse('2024-01-03T12Z'),
          DateTime.parse('2024-01-03T19Z'),
          DateTime.parse('2024-01-04T00Z'),
        ],
      );
    });

    test('.toList() handle list in day field correctly', () {
      expect(
        Cron.parse('0 0 6,9 * *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-04-01T00Z'),
        ),
        [
          DateTime.parse('2024-01-06T00Z'),
          DateTime.parse('2024-01-09T00Z'),
          DateTime.parse('2024-02-06T00Z'),
          DateTime.parse('2024-02-09T00Z'),
          DateTime.parse('2024-03-06T00Z'),
          DateTime.parse('2024-03-09T00Z'),
        ],
      );
    });

    test('.toList() handle repeat in day field correctly', () {
      expect(
        Cron.parse('0 0 25/3 * *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-04-01T00Z'),
        ),
        [
          DateTime.parse('2024-01-25T00Z'),
          DateTime.parse('2024-01-28T00Z'),
          DateTime.parse('2024-01-31T00Z'),
          DateTime.parse('2024-02-25T00Z'),
          DateTime.parse('2024-02-28T00Z'),
          DateTime.parse('2024-03-25T00Z'),
          DateTime.parse('2024-03-28T00Z'),
          DateTime.parse('2024-03-31T00Z'),
        ],
      );
    });

    test('.toList() handle range in day field correctly', () {
      expect(
        Cron.parse('0 0 2-4 * *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-04-01T00Z'),
        ),
        [
          DateTime.parse('2024-01-02T00Z'),
          DateTime.parse('2024-01-03T00Z'),
          DateTime.parse('2024-01-04T00Z'),
          DateTime.parse('2024-02-02T00Z'),
          DateTime.parse('2024-02-03T00Z'),
          DateTime.parse('2024-02-04T00Z'),
          DateTime.parse('2024-03-02T00Z'),
          DateTime.parse('2024-03-03T00Z'),
          DateTime.parse('2024-03-04T00Z'),
        ],
      );
    });

    test('.toList() handle repeat and range in day field correctly', () {
      expect(
        Cron.parse('0 0 3-18/5 * *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-04-01T00Z'),
        ),
        [
          DateTime.parse('2024-01-03T00Z'),
          DateTime.parse('2024-01-08T00Z'),
          DateTime.parse('2024-01-13T00Z'),
          DateTime.parse('2024-01-18T00Z'),
          DateTime.parse('2024-02-03T00Z'),
          DateTime.parse('2024-02-08T00Z'),
          DateTime.parse('2024-02-13T00Z'),
          DateTime.parse('2024-02-18T00Z'),
          DateTime.parse('2024-03-03T00Z'),
          DateTime.parse('2024-03-08T00Z'),
          DateTime.parse('2024-03-13T00Z'),
          DateTime.parse('2024-03-18T00Z'),
        ],
      );
    });

    test('.toList() handle last day in day field correctly', () {
      expect(
        Cron.parse('0 0 L * *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-04-01T00Z'),
        ),
        [
          DateTime.parse('2024-01-31T00Z'),
          DateTime.parse('2024-02-29T00Z'),
          DateTime.parse('2024-03-31T00Z'),
        ],
      );
    });

    test('.toList() handle multiple format in day field correctly', () {
      expect(
        Cron.parse('0 0 1,2-5/3,4,7/6,L * *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-04-01T00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-01-02T00Z'),
          DateTime.parse('2024-01-04T00Z'),
          DateTime.parse('2024-01-05T00Z'),
          DateTime.parse('2024-01-07T00Z'),
          DateTime.parse('2024-01-13T00Z'),
          DateTime.parse('2024-01-19T00Z'),
          DateTime.parse('2024-01-25T00Z'),
          DateTime.parse('2024-01-31T00Z'),
          DateTime.parse('2024-02-01T00Z'),
          DateTime.parse('2024-02-02T00Z'),
          DateTime.parse('2024-02-04T00Z'),
          DateTime.parse('2024-02-05T00Z'),
          DateTime.parse('2024-02-07T00Z'),
          DateTime.parse('2024-02-13T00Z'),
          DateTime.parse('2024-02-19T00Z'),
          DateTime.parse('2024-02-25T00Z'),
          DateTime.parse('2024-03-01T00Z'),
          DateTime.parse('2024-03-02T00Z'),
          DateTime.parse('2024-03-04T00Z'),
          DateTime.parse('2024-03-05T00Z'),
          DateTime.parse('2024-03-07T00Z'),
          DateTime.parse('2024-03-13T00Z'),
          DateTime.parse('2024-03-19T00Z'),
          DateTime.parse('2024-03-25T00Z'),
          DateTime.parse('2024-03-31T00Z'),
          DateTime.parse('2024-04-01T00Z'),
        ],
      );
    });

    test('.toList() handle list in month field correctly', () {
      expect(
        Cron.parse('0 0 L 6,8 *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2027-01-31T00Z'),
        ),
        [
          DateTime.parse('2024-06-30T00Z'),
          DateTime.parse('2024-08-31T00Z'),
          DateTime.parse('2025-06-30T00Z'),
          DateTime.parse('2025-08-31T00Z'),
          DateTime.parse('2026-06-30T00Z'),
          DateTime.parse('2026-08-31T00Z'),
        ],
      );
    });

    test('.toList() handle repeat in month field correctly', () {
      expect(
        Cron.parse('0 0 L 4/3 *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2027-01-31T00Z'),
        ),
        [
          DateTime.parse('2024-04-30T00Z'),
          DateTime.parse('2024-07-31T00Z'),
          DateTime.parse('2024-10-31T00Z'),
          DateTime.parse('2025-04-30T00Z'),
          DateTime.parse('2025-07-31T00Z'),
          DateTime.parse('2025-10-31T00Z'),
          DateTime.parse('2026-04-30T00Z'),
          DateTime.parse('2026-07-31T00Z'),
          DateTime.parse('2026-10-31T00Z'),
        ],
      );
    });

    test('.toList() handle range in month field correctly', () {
      expect(
        Cron.parse('0 0 L 2-4 *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2027-01-31T00Z'),
        ),
        [
          DateTime.parse('2024-02-29T00Z'),
          DateTime.parse('2024-03-31T00Z'),
          DateTime.parse('2024-04-30T00Z'),
          DateTime.parse('2025-02-28T00Z'),
          DateTime.parse('2025-03-31T00Z'),
          DateTime.parse('2025-04-30T00Z'),
          DateTime.parse('2026-02-28T00Z'),
          DateTime.parse('2026-03-31T00Z'),
          DateTime.parse('2026-04-30T00Z'),
        ],
      );
    });

    test('.toList() handle repeat and range in month field correctly', () {
      expect(
        Cron.parse('0 0 L 3-10/6 *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2027-01-31T00Z'),
        ),
        [
          DateTime.parse('2024-03-31T00Z'),
          DateTime.parse('2024-09-30T00Z'),
          DateTime.parse('2025-03-31T00Z'),
          DateTime.parse('2025-09-30T00Z'),
          DateTime.parse('2026-03-31T00Z'),
          DateTime.parse('2026-09-30T00Z'),
        ],
      );
    });

    test('.toList() handle multiple format in month field correctly', () {
      expect(
        Cron.parse('0 0 L 1,4,3-7/2,8,5/6 *').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2027-01-31T00Z'),
        ),
        [
          DateTime.parse('2024-01-31T00Z'),
          DateTime.parse('2024-03-31T00Z'),
          DateTime.parse('2024-04-30T00Z'),
          DateTime.parse('2024-05-31T00Z'),
          DateTime.parse('2024-07-31T00Z'),
          DateTime.parse('2024-08-31T00Z'),
          DateTime.parse('2024-11-30T00Z'),
          DateTime.parse('2025-01-31T00Z'),
          DateTime.parse('2025-03-31T00Z'),
          DateTime.parse('2025-04-30T00Z'),
          DateTime.parse('2025-05-31T00Z'),
          DateTime.parse('2025-07-31T00Z'),
          DateTime.parse('2025-08-31T00Z'),
          DateTime.parse('2025-11-30T00Z'),
          DateTime.parse('2026-01-31T00Z'),
          DateTime.parse('2026-03-31T00Z'),
          DateTime.parse('2026-04-30T00Z'),
          DateTime.parse('2026-05-31T00Z'),
          DateTime.parse('2026-07-31T00Z'),
          DateTime.parse('2026-08-31T00Z'),
          DateTime.parse('2026-11-30T00Z'),
          DateTime.parse('2027-01-31T00Z'),
        ],
      );
    });

    test('.toList() handle list in weekday field correctly', () {
      expect(
        Cron.parse('0 0 * * 2,4').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-03-01T00Z'),
        ),
        [
          DateTime.parse('2024-01-02T00Z'),
          DateTime.parse('2024-01-04T00Z'),
          DateTime.parse('2024-01-09T00Z'),
          DateTime.parse('2024-01-11T00Z'),
          DateTime.parse('2024-01-16T00Z'),
          DateTime.parse('2024-01-18T00Z'),
          DateTime.parse('2024-01-23T00Z'),
          DateTime.parse('2024-01-25T00Z'),
          DateTime.parse('2024-01-30T00Z'),
          DateTime.parse('2024-02-01T00Z'),
          DateTime.parse('2024-02-06T00Z'),
          DateTime.parse('2024-02-08T00Z'),
          DateTime.parse('2024-02-13T00Z'),
          DateTime.parse('2024-02-15T00Z'),
          DateTime.parse('2024-02-20T00Z'),
          DateTime.parse('2024-02-22T00Z'),
          DateTime.parse('2024-02-27T00Z'),
          DateTime.parse('2024-02-29T00Z'),
        ],
      );
    });

    test('.toList() handle repeat in weekday field correctly', () {
      expect(
        Cron.parse('0 0 * * 3/2').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-03-01T00Z'),
        ),
        [
          DateTime.parse('2024-01-03T00Z'),
          DateTime.parse('2024-01-05T00Z'),
          DateTime.parse('2024-01-07T00Z'),
          DateTime.parse('2024-01-10T00Z'),
          DateTime.parse('2024-01-12T00Z'),
          DateTime.parse('2024-01-14T00Z'),
          DateTime.parse('2024-01-17T00Z'),
          DateTime.parse('2024-01-19T00Z'),
          DateTime.parse('2024-01-21T00Z'),
          DateTime.parse('2024-01-24T00Z'),
          DateTime.parse('2024-01-26T00Z'),
          DateTime.parse('2024-01-28T00Z'),
          DateTime.parse('2024-01-31T00Z'),
          DateTime.parse('2024-02-02T00Z'),
          DateTime.parse('2024-02-04T00Z'),
          DateTime.parse('2024-02-07T00Z'),
          DateTime.parse('2024-02-09T00Z'),
          DateTime.parse('2024-02-11T00Z'),
          DateTime.parse('2024-02-14T00Z'),
          DateTime.parse('2024-02-16T00Z'),
          DateTime.parse('2024-02-18T00Z'),
          DateTime.parse('2024-02-21T00Z'),
          DateTime.parse('2024-02-23T00Z'),
          DateTime.parse('2024-02-25T00Z'),
          DateTime.parse('2024-02-28T00Z'),
          DateTime.parse('2024-03-01T00Z'),
        ],
      );
    });

    test('.toList() handle range in weekday field correctly', () {
      expect(
        Cron.parse('0 0 * * 0-2').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-03-01T00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-01-02T00Z'),
          DateTime.parse('2024-01-07T00Z'),
          DateTime.parse('2024-01-08T00Z'),
          DateTime.parse('2024-01-09T00Z'),
          DateTime.parse('2024-01-14T00Z'),
          DateTime.parse('2024-01-15T00Z'),
          DateTime.parse('2024-01-16T00Z'),
          DateTime.parse('2024-01-21T00Z'),
          DateTime.parse('2024-01-22T00Z'),
          DateTime.parse('2024-01-23T00Z'),
          DateTime.parse('2024-01-28T00Z'),
          DateTime.parse('2024-01-29T00Z'),
          DateTime.parse('2024-01-30T00Z'),
          DateTime.parse('2024-02-04T00Z'),
          DateTime.parse('2024-02-05T00Z'),
          DateTime.parse('2024-02-06T00Z'),
          DateTime.parse('2024-02-11T00Z'),
          DateTime.parse('2024-02-12T00Z'),
          DateTime.parse('2024-02-13T00Z'),
          DateTime.parse('2024-02-18T00Z'),
          DateTime.parse('2024-02-19T00Z'),
          DateTime.parse('2024-02-20T00Z'),
          DateTime.parse('2024-02-25T00Z'),
          DateTime.parse('2024-02-26T00Z'),
          DateTime.parse('2024-02-27T00Z'),
        ],
      );
    });

    test('.toList() handle repeat and range in weekday field correctly', () {
      expect(
        Cron.parse('0 0 * * 2-6/3').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-03-01T00Z'),
        ),
        [
          DateTime.parse('2024-01-02T00Z'),
          DateTime.parse('2024-01-05T00Z'),
          DateTime.parse('2024-01-09T00Z'),
          DateTime.parse('2024-01-12T00Z'),
          DateTime.parse('2024-01-16T00Z'),
          DateTime.parse('2024-01-19T00Z'),
          DateTime.parse('2024-01-23T00Z'),
          DateTime.parse('2024-01-26T00Z'),
          DateTime.parse('2024-01-30T00Z'),
          DateTime.parse('2024-02-02T00Z'),
          DateTime.parse('2024-02-06T00Z'),
          DateTime.parse('2024-02-09T00Z'),
          DateTime.parse('2024-02-13T00Z'),
          DateTime.parse('2024-02-16T00Z'),
          DateTime.parse('2024-02-20T00Z'),
          DateTime.parse('2024-02-23T00Z'),
          DateTime.parse('2024-02-27T00Z'),
          DateTime.parse('2024-03-01T00Z'),
        ],
      );
    });

    test('.toList() handle last day in weekday field correctly', () {
      expect(
        Cron.parse('0 0 * * 0L').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-04-01T00Z'),
        ),
        [
          DateTime.parse('2024-01-28T00Z'),
          DateTime.parse('2024-02-25T00Z'),
          DateTime.parse('2024-03-31T00Z'),
        ],
      );
    });

    test('.toList() handle nth weekday in weekday field correctly', () {
      expect(
        Cron.parse('0 0 * * 3#5').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2025-01-01T00Z'),
        ),
        [
          DateTime.parse('2024-01-31T00Z'),
          DateTime.parse('2024-05-29T00Z'),
          DateTime.parse('2024-07-31T00Z'),
          DateTime.parse('2024-10-30T00Z'),
        ],
      );
    });

    test('.toList() handle multiple format in weekday field correctly', () {
      expect(
        Cron.parse('0 0 * * 1,2-5/3,4L').toList(
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-03-01T00Z'),
        ),
        [
          DateTime.parse('2024-01-01T00Z'),
          DateTime.parse('2024-01-02T00Z'),
          DateTime.parse('2024-01-05T00Z'),
          DateTime.parse('2024-01-08T00Z'),
          DateTime.parse('2024-01-09T00Z'),
          DateTime.parse('2024-01-12T00Z'),
          DateTime.parse('2024-01-15T00Z'),
          DateTime.parse('2024-01-16T00Z'),
          DateTime.parse('2024-01-19T00Z'),
          DateTime.parse('2024-01-22T00Z'),
          DateTime.parse('2024-01-23T00Z'),
          DateTime.parse('2024-01-25T00Z'),
          DateTime.parse('2024-01-26T00Z'),
          DateTime.parse('2024-01-29T00Z'),
          DateTime.parse('2024-01-30T00Z'),
          DateTime.parse('2024-02-02T00Z'),
          DateTime.parse('2024-02-05T00Z'),
          DateTime.parse('2024-02-06T00Z'),
          DateTime.parse('2024-02-09T00Z'),
          DateTime.parse('2024-02-12T00Z'),
          DateTime.parse('2024-02-13T00Z'),
          DateTime.parse('2024-02-16T00Z'),
          DateTime.parse('2024-02-19T00Z'),
          DateTime.parse('2024-02-20T00Z'),
          DateTime.parse('2024-02-23T00Z'),
          DateTime.parse('2024-02-26T00Z'),
          DateTime.parse('2024-02-27T00Z'),
          DateTime.parse('2024-02-29T00Z'),
          DateTime.parse('2024-03-01T00Z'),
        ],
      );
    });
  });

  group('test', () {
    test('example 1', () {
      // Every 20 minutes
      final cron = Cron.parse('*/20 * * * *');
      print(cron.toList(
        DateTime.parse('2000-01-01T00:00Z'),
        DateTime.parse('2000-01-01T01:00Z'),
      ));

      // [2000-01-01 00:00:00.000Z, 2000-01-01 00:20:00.000Z, 2000-01-01 00:40:00.000Z, 2000-01-01 01:00:00.000Z]
    });

    test('example 2', () {
      // At midnight on the last day of the month
      final cron = Cron.parse('0 0 L * *');
      print(cron.next(DateTime.parse('2000-02-01T00:00Z')));

      // 2000-02-29 00:00:00.000Z
    });
  });
}
