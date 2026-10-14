/// Format ngày tháng tiếng Việt cho bài giảng
class DateFormatter {
  DateFormatter._();

  static String formatRelative(DateTime date, [DateTime? clock]) {
    final now = clock ?? DateTime.now();

    // Xử lý thời gian trong tương lai (do lệch đồng hồ thiết bị)
    if (date.isAfter(now)) {
      return 'Vừa xong';
    }

    final difference = now.difference(date);

    // Dưới 1 phút
    if (difference.inMinutes < 1) {
      return 'Vừa xong';
    }

    // Dưới 1 giờ: hiển thị số phút trước
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    }

    // So sánh theo ngày lịch thực tế (Calendar Day)
    final today = DateTime(now.year, now.month, now.day);
    final eventDay = DateTime(date.year, date.month, date.day);
    final daysAgo = today.difference(eventDay).inDays;

    final timeStr =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    if (daysAgo == 0) {
      return 'Hôm nay $timeStr';
    } else if (daysAgo == 1) {
      return 'Hôm qua $timeStr';
    } else if (daysAgo < 7) {
      return '$daysAgo ngày trước';
    } else {
      return '${date.day} Th${date.month}, ${date.year}';
    }
  }
}
