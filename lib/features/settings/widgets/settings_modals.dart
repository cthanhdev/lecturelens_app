import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/motion/app_motion_tokens.dart';
import '../../../core/providers/app_state_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/buttons/ll_primary_button.dart';
import '../../../shared/widgets/buttons/ll_secondary_button.dart';
import '../../../shared/widgets/inputs/ll_text_field.dart';
import '../../../shared/widgets/interactive/ll_pressable.dart';
import '../../../shared/widgets/interactive/ll_spring_switch.dart';

/// !IMPORTANT: SettingsModals — Tập hợp các Modal Sheet & Dialog chuẩn Apple
/// CHỈ DẪN: Mọi thao tác lưu dữ liệu đều dùng phản hồi trực quan tại chỗ (In-place visual feedback:
/// loading -> bouncy checkmark) trong nút bấm, KHÔNG dùng Toast/SnackBar.
class SettingsModals {
  SettingsModals._();

  // ==========================================
  // 1. CHỈNH SỬA HỒ SƠ (Profile Editor Sheet)
  // ==========================================
  static void showEditProfile(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _EditProfileSheet(ref: ref),
    );
  }

  // ==========================================
  // 2. ĐỔI MẬT KHẨU (Change Password Sheet)
  // ==========================================
  static void showChangePassword(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => const _ChangePasswordSheet(),
    );
  }

  // ==========================================
  // 3. TÀI KHOẢN LIÊN KẾT (Linked Accounts Sheet)
  // ==========================================
  static void showLinkedAccounts(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _LinkedAccountsSheet(ref: ref),
    );
  }

  // ==========================================
  // 4. CHỌN NGÔN NGỮ (Language Picker Sheet)
  // ==========================================
  static void showLanguagePicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _LanguagePickerSheet(ref: ref),
    );
  }

  // ==========================================
  // 5. QUẢN LÝ QUYỀN (Permissions Sheet)
  // ==========================================
  static void showPermissions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => const _PermissionsSheet(),
    );
  }

  // ==========================================
  // 6. ĐIỀU KHOẢN & CHÍNH SÁCH (Terms Sheet)
  // ==========================================
  static void showTermsAndPrivacy(BuildContext context, {required bool isTerms}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _TermsSheet(isTerms: isTerms),
    );
  }

  // ==========================================
  // 7. LIÊN HỆ HỖ TRỢ (Support Sheet)
  // ==========================================
  static void showSupport(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => const _SupportSheet(),
    );
  }

  // ==========================================
  // 8. XÁC NHẬN ĐĂNG XUẤT (Logout Dialog)
  // ==========================================
  static void showLogoutConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: Theme.of(dialogCtx).brightness == Brightness.dark
            ? AppColors.darkSurfaceCard
            : AppColors.surfaceCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: Theme.of(dialogCtx).brightness == Brightness.dark
                ? AppColors.darkOutline
                : AppColors.outline,
          ),
        ),
        title: const Row(
          children: [
            Icon(Icons.logout_rounded, color: Color(0xFFE11D48), size: 22),
            SizedBox(width: 8),
            Text(
              'Đăng xuất tài khoản',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ],
        ),
        content: const Text(
          'Bạn có chắc chắn muốn đăng xuất khỏi LectureLens? Mọi bài giảng đã lưu vẫn sẽ an toàn trên thiết bị của bạn.',
          style: TextStyle(fontSize: 14, height: 1.4, color: AppColors.onSurfaceVariant),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text(
              'Ở lại học tiếp',
              style: TextStyle(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE11D48),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              context.go(AppConstants.routeLogin);
            },
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 9. XÓA TÀI KHOẢN (2-Step Delete Dialog)
  // ==========================================
  static void showDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => const _DeleteAccountTwoStepDialog(),
    );
  }
}

// -------------------------------------------------------------
// IMPLEMENTATION WIDGETS
// -------------------------------------------------------------

class _SheetContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const _SheetContainer({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceCard : AppColors.surfaceCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Grab handle
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(top: 10, bottom: 12),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkOutline : AppColors.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 20),
                      color: isDark ? AppColors.darkOnSurfaceVariant : AppColors.onSurfaceVariant,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(20),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 1. Edit Profile Sheet
class _EditProfileSheet extends StatefulWidget {
  final WidgetRef ref;
  const _EditProfileSheet({required this.ref});

  @override
  State<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<_EditProfileSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _schoolController;
  bool _isLoading = false;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    final profile = widget.ref.read(userProfileProvider);
    _nameController = TextEditingController(text: profile.name);
    _schoolController = TextEditingController(text: profile.school);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  void _handleSave() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 550), () {
      if (!mounted) return;
      widget.ref.read(userProfileProvider.notifier).update((state) {
        final newName = _nameController.text.trim();
        final initial = newName.isNotEmpty ? newName[0].toUpperCase() : state.avatarInitial;
        return state.copyWith(
          name: newName.isNotEmpty ? newName : state.name,
          school: _schoolController.text.trim().isNotEmpty ? _schoolController.text.trim() : state.school,
          avatarInitial: initial,
        );
      });

      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });

      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _SheetContainer(
      title: 'Chỉnh sửa hồ sơ',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryContainer],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _nameController.text.isNotEmpty ? _nameController.text[0].toUpperCase() : 'M',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.camera_alt_rounded, size: 13, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          LlTextField(
            controller: _nameController,
            label: 'Họ và tên',
            hintText: 'Nhập tên hiển thị',
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 14),
          LlTextField(
            controller: _schoolController,
            label: 'Trường / Ngành học',
            hintText: 'Nhập thông tin ngành học',
          ),
          const SizedBox(height: 24),
          LlPrimaryButton(
            text: 'Lưu thay đổi',
            isLoading: _isLoading,
            isSuccess: _isSuccess,
            onPressed: _handleSave,
          ),
        ],
      ),
    );
  }
}

// 2. Change Password Sheet
class _ChangePasswordSheet extends StatefulWidget {
  const _ChangePasswordSheet();

  @override
  State<_ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<_ChangePasswordSheet> {
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();
  bool _isLoading = false;
  bool _isSuccess = false;

  void _handleUpdatePassword() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _SheetContainer(
      title: 'Đổi mật khẩu',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LlTextField(
            controller: _oldPassController,
            label: 'Mật khẩu hiện tại',
            hintText: 'Nhập mật khẩu đang dùng',
            obscureText: true,
          ),
          const SizedBox(height: 14),
          LlTextField(
            controller: _newPassController,
            label: 'Mật khẩu mới',
            hintText: 'Tối thiểu 8 ký tự',
            obscureText: true,
          ),
          const SizedBox(height: 14),
          LlTextField(
            controller: _confirmPassController,
            label: 'Xác nhận mật khẩu mới',
            hintText: 'Nhập lại mật khẩu mới',
            obscureText: true,
          ),
          const SizedBox(height: 24),
          LlPrimaryButton(
            text: 'Cập nhật mật khẩu',
            isLoading: _isLoading,
            isSuccess: _isSuccess,
            onPressed: _handleUpdatePassword,
          ),
        ],
      ),
    );
  }
}

// 3. Linked Accounts Sheet
class _LinkedAccountsSheet extends ConsumerWidget {
  final WidgetRef ref;
  const _LinkedAccountsSheet({required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(connectedAccountsProvider);

    return _SheetContainer(
      title: 'Tài khoản liên kết',
      child: Column(
        children: accounts.entries.map((entry) {
          final provider = entry.key;
          final isLinked = entry.value;

          IconData icon;
          switch (provider) {
            case 'Google':
              icon = Icons.g_mobiledata_rounded;
              break;
            case 'Apple':
              icon = Icons.apple_rounded;
              break;
            case 'Microsoft':
              icon = Icons.window_rounded;
              break;
            default:
              icon = Icons.code_rounded;
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkSurfaceContainer
                  : AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(icon, size: 24, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    provider,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                LlSpringSwitch(
                  value: isLinked,
                  onChanged: (val) {
                    ref.read(connectedAccountsProvider.notifier).update((state) {
                      final updated = Map<String, bool>.from(state);
                      updated[provider] = val;
                      return updated;
                    });
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// 4. Language Picker Sheet
class _LanguagePickerSheet extends ConsumerWidget {
  final WidgetRef ref;
  const _LanguagePickerSheet({required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLang = ref.watch(selectedLanguageProvider);
    final languages = ['Tiếng Việt', 'English'];

    return _SheetContainer(
      title: 'Chọn ngôn ngữ',
      child: Column(
        children: languages.map((lang) {
          final isSelected = lang == currentLang;

          return LlPressable(
            scaleFactor: AppMotionTokens.pressScale,
            onTap: () {
              ref.read(selectedLanguageProvider.notifier).state = lang;
              Future.delayed(const Duration(milliseconds: 250), () {
                if (context.mounted) Navigator.of(context).pop();
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryLight : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.outline,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lang,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? AppColors.primary : AppColors.onSurface,
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 20),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// 5. Permissions Sheet
class _PermissionsSheet extends StatelessWidget {
  const _PermissionsSheet();

  @override
  Widget build(BuildContext context) {
    return _SheetContainer(
      title: 'Quyền riêng tư & Thiết bị',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPermItem(
            icon: Icons.mic_rounded,
            title: 'Microphone',
            description: 'Dùng để thu âm giọng giảng viên trực tiếp trong lớp học.',
            isGranted: true,
          ),
          const SizedBox(height: 14),
          _buildPermItem(
            icon: Icons.folder_rounded,
            title: 'Bộ nhớ thiết bị',
            description: 'Lưu trữ tệp âm thanh bài giảng và bản sao chép ngoại tuyến.',
            isGranted: true,
          ),
          const SizedBox(height: 14),
          _buildPermItem(
            icon: Icons.notifications_rounded,
            title: 'Thông báo đẩy',
            description: 'Nhận thông báo khi Cú Mèo AI hoàn tất tóm tắt bài giảng.',
            isGranted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPermItem({
    required IconData icon,
    required String title,
    required String description,
    required bool isGranted,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.mintGreen,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'Đã cấp quyền',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.mintGreenDark),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 6. Terms Sheet
class _TermsSheet extends StatelessWidget {
  final bool isTerms;
  const _TermsSheet({required this.isTerms});

  @override
  Widget build(BuildContext context) {
    return _SheetContainer(
      title: isTerms ? 'Điều khoản dịch vụ' : 'Chính sách bảo mật',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isTerms
                  ? 'Chào mừng bạn đến với LectureLens. Ứng dụng cung cấp công cụ AI ghi nhận và tóm tắt bài giảng nhằm mục đích hỗ trợ học tập cá nhân.'
                  : 'LectureLens cam kết bảo vệ dữ liệu học tập của sinh viên. Mọi bản ghi âm và tài liệu trích xuất chỉ được xử lý phục vụ nhu cầu ôn tập của chính bạn.',
              style: const TextStyle(fontSize: 14, height: 1.5, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            const Text(
              '1. Bản quyền nội dung bài giảng thuộc về giảng viên và cơ sở đào tạo.',
              style: TextStyle(fontSize: 13, height: 1.4, color: AppColors.onSurface),
            ),
            const SizedBox(height: 8),
            const Text(
              '2. Dữ liệu xử lý AI được mã hóa an toàn trên đường truyền và tại điểm lưu trữ.',
              style: TextStyle(fontSize: 13, height: 1.4, color: AppColors.onSurface),
            ),
            const SizedBox(height: 20),
            LlSecondaryButton(
              text: 'Đã hiểu và đồng ý',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

// 7. Support Sheet
class _SupportSheet extends StatelessWidget {
  const _SupportSheet();

  @override
  Widget build(BuildContext context) {
    return _SheetContainer(
      title: 'Hỗ trợ sinh viên',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Bạn gặp sự cố khi xử lý bài giảng hoặc có ý kiến đóng góp cho Cú Mèo? Đội ngũ phát triển luôn sẵn sàng hỗ trợ!',
            style: TextStyle(fontSize: 14, height: 1.4, color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          _buildContactRow(Icons.mail_outline_rounded, 'Email hỗ trợ', 'support@lecturelens.edu.vn'),
          const SizedBox(height: 10),
          _buildContactRow(Icons.chat_bubble_outline_rounded, 'Cộng đồng sinh viên', 't.me/lecturelens_students'),
          const SizedBox(height: 20),
          LlPrimaryButton(
            text: 'Gửi phản hồi nhanh 💌',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

// 9. Two-step Delete Account Dialog
class _DeleteAccountTwoStepDialog extends StatefulWidget {
  const _DeleteAccountTwoStepDialog();

  @override
  State<_DeleteAccountTwoStepDialog> createState() => _DeleteAccountTwoStepDialogState();
}

class _DeleteAccountTwoStepDialogState extends State<_DeleteAccountTwoStepDialog> {
  int _step = 1;
  final _confirmInputController = TextEditingController();
  bool _isDeleting = false;

  @override
  void dispose() {
    _confirmInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: isDark ? AppColors.darkSurfaceCard : AppColors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: isDark ? AppColors.darkOutline : AppColors.outline),
      ),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Color(0xFFE11D48), size: 24),
          const SizedBox(width: 8),
          Text(
            _step == 1 ? 'Xóa tài khoản vĩnh viễn' : 'Xác nhận bước cuối (2/2)',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
      content: _step == 1
          ? const Text(
              'Hành động này KHÔNG THỂ HOÀN TÁC. Toàn bộ bài giảng, bản ghi âm, câu hỏi ôn tập và dữ liệu Cú Mèo AI sẽ bị xóa vĩnh viễn khỏi thiết bị.',
              style: TextStyle(fontSize: 14, height: 1.4, color: AppColors.onSurfaceVariant),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vui lòng nhập chữ "XOA" vào ô bên dưới để xác nhận bạn hiểu rõ rủi ro mất toàn bộ bài giảng:',
                  style: TextStyle(fontSize: 13, height: 1.4, color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 12),
                LlTextField(
                  controller: _confirmInputController,
                  hintText: 'Nhập XOA để xác nhận',
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy bỏ', style: TextStyle(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.bold)),
        ),
        if (_step == 1)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE11D48),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            onPressed: () => setState(() => _step = 2),
            child: const Text('Tiếp tục bước 2 →'),
          )
        else
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE11D48),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            onPressed: _confirmInputController.text.trim().toUpperCase() == 'XOA' && !_isDeleting
                ? () {
                    setState(() => _isDeleting = true);
                    Future.delayed(const Duration(milliseconds: 600), () {
                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                      context.go(AppConstants.routeLogin);
                    });
                  }
                : null,
            child: _isDeleting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.white)),
                  )
                : const Text('Xóa tài khoản ngay'),
          ),
      ],
    );
  }
}
