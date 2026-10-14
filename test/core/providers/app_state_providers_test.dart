import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecturelens_app/core/providers/app_state_providers.dart';
import 'package:lecturelens_app/shared/models/notification_ui_model.dart';

void main() {
  group('AppStateProviders Tests', () {
    test('hasCompletedOnboardingProvider default value is false and updates correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(hasCompletedOnboardingProvider), isFalse);

      container.read(hasCompletedOnboardingProvider.notifier).state = true;
      expect(container.read(hasCompletedOnboardingProvider), isTrue);
    });

    test('userProfileProvider holds valid default data and supports copyWith', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final profile = container.read(userProfileProvider);
      expect(profile.name, isNotEmpty);
      expect(profile.email, contains('@'));
      expect(profile.school, isNotEmpty);
      expect(profile.avatarInitial, 'M');

      final updated = profile.copyWith(name: 'Nguyễn Văn A');
      expect(updated.name, 'Nguyễn Văn A');
      expect(updated.email, profile.email);
    });

    test('unreadNotificationCountProvider accurately counts unread notifications', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final initialUnread = container.read(unreadNotificationCountProvider);
      expect(initialUnread, greaterThanOrEqualTo(0));

      // Overwrite notifications with known read/unread items
      container.read(notificationsProvider.notifier).state = [
        const NotificationUiModel(
          id: '1',
          title: 'Notif 1',
          message: 'Msg 1',
          time: '1m ago',
          type: NotificationType.processingDone,
          isRead: false,
        ),
        const NotificationUiModel(
          id: '2',
          title: 'Notif 2',
          message: 'Msg 2',
          time: '2m ago',
          type: NotificationType.studyReminder,
          isRead: true,
        ),
      ];

      expect(container.read(unreadNotificationCountProvider), 1);
    });
  });
}
