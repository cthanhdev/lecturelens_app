import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Thẻ Hồ Sơ Sinh Viên
class ProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String school;
  final VoidCallback? onLogout;

  const ProfileCard({
    super.key,
    this.name = 'Minh Trần',
    this.email = 'minh.tran@bachkhoa.edu.vn',
    this.school = 'Kỹ thuật phần mềm • ĐH Bách Khoa',
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outline),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryContainer.withOpacity(0.24),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'M',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                        fontSize: 16,
                      ),
                ),
                Text(
                  school,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                ),
                Text(
                  email,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 11,
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, size: 20),
            color: AppColors.coralDark,
            tooltip: 'Đăng xuất',
            onPressed: onLogout,
          ),
        ],
      ),
    );
  }
}
