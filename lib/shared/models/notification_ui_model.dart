enum NotificationType {
  processingDone,
  systemUpdate,
  studyReminder,
}

/// Model hiển thị thông báo
class NotificationUiModel {
  final String id;
  final String title;
  final String message;
  final String time;
  final NotificationType type;
  final bool isRead;
  final String? lectureId;

  const NotificationUiModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
    this.lectureId,
  });

  static List<NotificationUiModel> mockNotifications = [
    const NotificationUiModel(
      id: 'notif_1',
      title: 'Xử lý hoàn tất 🎉',
      message: 'Bài giảng "Lập trình Web - REST API" đã được Cú Mèo tổng hợp xong mục lục và trích dẫn trọng tâm!',
      time: '10 phút trước',
      type: NotificationType.processingDone,
      isRead: false,
      lectureId: 'lec_1',
    ),
    const NotificationUiModel(
      id: 'notif_2',
      title: 'Nhắc nhở ôn tập 📚',
      message: 'Bạn có bài thi môn Xác suất thống kê sắp tới, hãy dành 15 phút ôn lại bài 5 nhé!',
      time: '2 giờ trước',
      type: NotificationType.studyReminder,
      isRead: false,
      lectureId: 'lec_3',
    ),
    const NotificationUiModel(
      id: 'notif_3',
      title: 'Cập nhật hệ thống ✨',
      message: 'LectureLens vừa nâng cấp mô hình AI hỏi đáp trích dẫn chính xác hơn 35%.',
      time: 'Hôm qua',
      type: NotificationType.systemUpdate,
      isRead: true,
    ),
  ];
}
