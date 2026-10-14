import 'package:flutter_test/flutter_test.dart';
import 'package:lecturelens_app/core/utils/duration_formatter.dart';

void main() {
  group('DurationFormatter Tests', () {
    test('Formats mm:ss when duration is under an hour', () {
      expect(DurationFormatter.format(const Duration(minutes: 5, seconds: 20)), '05:20');
      expect(DurationFormatter.format(Duration.zero), '00:00');
      expect(DurationFormatter.format(const Duration(seconds: 9)), '00:09');
    });

    test('Formats hh:mm:ss when duration is an hour or more', () {
      expect(DurationFormatter.format(const Duration(hours: 1, minutes: 2, seconds: 3)), '01:02:03');
      expect(DurationFormatter.format(const Duration(hours: 2, minutes: 45, seconds: 20)), '02:45:20');
    });

    test('Formats total seconds into minutes string with suffix', () {
      expect(DurationFormatter.formatMinutes(2720), '45:20 phút');
      expect(DurationFormatter.formatMinutes(0), '00:00 phút');
      expect(DurationFormatter.formatMinutes(65), '01:05 phút');
    });

    test('Handles negative duration gracefully by clamping to zero', () {
      expect(DurationFormatter.format(const Duration(seconds: -15)), '00:00');
      expect(DurationFormatter.formatMinutes(-100), '00:00 phút');
    });
  });
}
