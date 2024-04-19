# cron_parser

Parses cron expression.

[![pub package](https://img.shields.io/pub/v/cron_parser.svg)](https://pub.dev/packages/cron_parser)

## Supported format

```
* * * * * *
┬ ┬ ┬ ┬ ┬ ┬
│ │ │ │ │ |
│ │ │ │ │ └───── weekday (0-7, 0 and 7 being Sunday)
│ │ │ │ └─────── month (1-12)
│ │ │ └───────── day (1-31)
│ │ └─────────── hour (0-23)
│ └───────────── minute (0-59)
└─────────────── second (0-59, optional)
```

### Special characters

#### Asterisk (`*`)

Represents all value.

#### Comma (`,`)

Used to separate multiple items of a list.

#### Hyphen (`-`)

Used to represent range of value.
For example `1-10` in minute field indicate iteration every minutes from minute `1` until minute `10`.

#### Slash (`/`)

Used to represent step value.
For example `*/2` in minute field indicate iteration every 2 minutes.

Combinable with hyphen, for example `0 10-20/5 * * *` indicate iteration every 5 hours started from `10:00` until `20:00`.

#### Hash (`#`)

Only for weekday field.

Used to represent nth weekday of the month.
For example `0 0 * * 6#3` indicate iteration at `00:00` on every third Saturday of the month.

#### `L`

Only for day and weekday field.

Used to represent last day of the month or last weekday of the month.
For example `0 0 L * *` indicate iteration at `00:00` on every last day of the month,
and `0 0 * * 1L` indicate iteration at `00:00` on every last Monday of the month.

## Usage

A simple usage example:

```dart
import 'package:cron_parser/cron_parser.dart';

// Every 20 minutes
final cron = Cron.parse('*/20 * * * *');
print(cron.toList(
  DateTime.parse('2000-01-01T00:00Z'),
  DateTime.parse('2000-01-01T01:00Z'),
));

// [2000-01-01 00:00:00.000Z, 2000-01-01 00:20:00.000Z, 2000-01-01 00:40:00.000Z, 2000-01-01 01:00:00.000Z]
```

Another example:

```dart
import 'package:cron_parser/cron_parser.dart';

// At midnight on the last day of the month
final cron = Cron.parse('0 0 L * *');
print(cron.next(DateTime.parse('2000-02-01T00:00Z')));

// 2000-02-29 00:00:00.000Z
```

## Links

- [source code][source]
- contributors: [Ilham F][ilhamft]

[source]: https://github.com/ilhamft/cron_parser
[ilhamft]: https://github.com/ilhamft
