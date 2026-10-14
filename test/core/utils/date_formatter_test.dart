import 'package:flutter_test/flutter_test.dart';
import 'package:lecturelens_app/core/utils/date_formatter.dart';

void main() {
  group('DateFormatter Tests', () {
    final fixedNow = DateTime(2026, 10, 14, 14, 30); // 14:30 on Oct 14, 2026

    test('Formats just now for future timestamps (clock skew guard)', () {
      final futureDate = fixedNow.add(const Duration(minutes: 5));
      final result = DateFormatter.formatRelative(futureDate, fixedNow);
      expect(result, 'Vừa xong');
    });

    test('Formats just now for events less than 1 minute ago', () {
      final justNow = fixedNow.subtract(const Duration(seconds: 40));
      final result = DateFormatter.formatRelative(justNow, fixedNow);
      expect(result, 'Vừa xong');
    });

    test('Formats minutes ago for events within same hour', () {
      final fifteenMinsAgo = fixedNow.subtract(const Duration(minutes: 15));
      final result = DateFormatter.formatRelative(fifteenMinsAgo, fixedNow);
      expect(result, '15 phút trước');
    });

    test('Formats today with time for earlier events on same calendar day', () {
      final earlierToday = DateTime(2026, 10, 14, 9, 15);
      final result = DateFormatter.formatRelative(earlierToday, fixedNow);
      expect(result, 'Hôm nay 09:15');
    });

    test('Correctly identifies yesterday even when exactly 23 hours ago', () {
      // 23 hours ago is Oct 13, 15:30 (yesterday afternoon)
      final yesterdayAfternoon = fixedNow.subtract(const Duration(hours: 23));
      final result = DateFormatter.formatRelative(yesterdayAfternoon, fixedNow);
      expect(result, 'Hôm qua 15:30');
    });

    test('Correctly identifies yesterday across midnight boundary (2 hours ago)', () {
      final midnightNow = DateTime(2026, 10, 14, 1, 0); // 01:00 Wednesday
      final lateTuesday = DateTime(2026, 10, 13, 23, 0); // 23:00 Tuesday
      final result = DateFormatter.formatRelative(lateTuesday, midnightNow);
      expect(result, 'Hôm qua 23:00');
    });

    test('Formats relative dates for days within a week', () {
      final threeDaysAgo = DateTime(2026, 10, 11, 10, 0);
      final result = DateFormatter.formatRelative(threeDaysAgo, fixedNow);
      expect(result, '3 ngày trước');
    });

    test('Formats full date for dates older than a week', () {
      final oldDate = DateTime(2025, 11, 20);
      final result = DateFormatter.formatRelative(oldDate, fixedNow);
      expect(result, '20 Th11, 2025');
    });

    test('Works with default DateTime.now() without crashing', () {
      final recent = DateTime.now().subtract(const Duration(minutes: 10));
      final result = DateFormatter.formatRelative(recent);
      expect(result, contains('phút trước'));
    });
  });
}
