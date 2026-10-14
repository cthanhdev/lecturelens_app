import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/models/notification_ui_model.dart';
import '../../shared/widgets/dot_background.dart';
import '../../shared/widgets/ll_app_bar.dart';
import 'widgets/notification_item.dart';

/// !IMPORTANT: Màn Hình Thông Báo (Notifications Screen)
/// CHỈ DẪN: Hiển thị các thông báo hoàn tất xử lý bài giảng, nhắc nhở ôn thi
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = NotificationUiModel.mockNotifications;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const LlAppBar(
        title: 'Thông báo',
        subtitle: 'Cập nhật từ giảng đường',
        showBack: true,
        showNotifications: false,
      ),
      body: DotBackground(
        child: SafeArea(
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return NotificationItemWidget(
                notification: notif,
                onTap: () {
                  if (notif.lectureId != null) {
                    context.push('/lecture/${notif.lectureId}');
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
