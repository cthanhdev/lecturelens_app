import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/models/notification_ui_model.dart';

/// Provider quản lý trạng thái đã xem qua Onboarding hay chưa
final hasCompletedOnboardingProvider = StateProvider<bool>((ref) => false);

/// Model thông tin người dùng sinh viên
class UserProfileData {
  final String name;
  final String email;
  final String school;
  final String avatarInitial;

  const UserProfileData({
    required this.name,
    required this.email,
    required this.school,
    required this.avatarInitial,
  });

  UserProfileData copyWith({
    String? name,
    String? email,
    String? school,
    String? avatarInitial,
  }) {
    return UserProfileData(
      name: name ?? this.name,
      email: email ?? this.email,
      school: school ?? this.school,
      avatarInitial: avatarInitial ?? this.avatarInitial,
    );
  }
}

/// Provider lưu trữ thông tin tài khoản sinh viên đăng nhập
final userProfileProvider = StateProvider<UserProfileData>((ref) {
  return const UserProfileData(
    name: 'Minh Trần',
    email: 'minh.tran@bachkhoa.edu.vn',
    school: 'Kỹ thuật phần mềm • ĐH Bách Khoa',
    avatarInitial: 'M',
  );
});

/// Provider danh sách thông báo
final notificationsProvider = StateProvider<List<NotificationUiModel>>((ref) {
  return NotificationUiModel.mockNotifications;
});

/// Provider đếm số thông báo chưa đọc
final unreadNotificationCountProvider = Provider<int>((ref) {
  final list = ref.watch(notificationsProvider);
  return list.where((n) => !n.isRead).length;
});

/// Provider bật/tắt thông báo đẩy
final notificationsEnabledProvider = StateProvider<bool>((ref) => true);

/// Provider khóa ứng dụng bảo mật FaceID / PIN (Stub cục bộ)
final appLockEnabledProvider = StateProvider<bool>((ref) => false);

/// Provider ngôn ngữ hiển thị
final selectedLanguageProvider = StateProvider<String>((ref) => 'Tiếng Việt');

/// Provider tài khoản liên kết xã hội (Stub cục bộ: Google, Apple, Microsoft, GitHub)
final connectedAccountsProvider = StateProvider<Map<String, bool>>((ref) {
  return {
    'Google': true,
    'Apple': false,
    'Microsoft': false,
    'GitHub': false,
  };
});

