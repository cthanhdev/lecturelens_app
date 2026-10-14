import 'package:flutter_test/flutter_test.dart';
import 'package:lecturelens_app/shared/models/notification_ui_model.dart';

void main() {
  group('NotificationUiModel Tests', () {
    test('mockNotifications contains valid sample notifications', () {
      expect(NotificationUiModel.mockNotifications, isNotEmpty);
      expect(NotificationUiModel.mockNotifications.length, 3);

      final first = NotificationUiModel.mockNotifications.first;
      expect(first.id, 'notif_1');
      expect(first.title, contains('Xử lý hoàn tất'));
      expect(first.type, NotificationType.processingDone);
      expect(first.isRead, isFalse);
      expect(first.lectureId, 'lec_1');
    });

    test('NotificationUiModel constructor sets all fields properly', () {
      const notif = NotificationUiModel(
        id: 'test_1',
        title: 'Title',
        message: 'Message',
        time: '5m',
        type: NotificationType.systemUpdate,
        isRead: true,
        lectureId: 'lec_99',
      );

      expect(notif.id, 'test_1');
      expect(notif.title, 'Title');
      expect(notif.message, 'Message');
      expect(notif.time, '5m');
      expect(notif.type, NotificationType.systemUpdate);
      expect(notif.isRead, isTrue);
      expect(notif.lectureId, 'lec_99');
    });
  });
}
