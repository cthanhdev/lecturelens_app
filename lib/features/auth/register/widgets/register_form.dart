import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/ll_primary_button.dart';
import '../../../../shared/widgets/inputs/ll_text_field.dart';

/// Form Đăng Ký
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _nameController = TextEditingController(text: 'Minh Trần');
  final _emailController = TextEditingController(text: 'minh.tran@bachkhoa.edu.vn');
  final _majorController = TextEditingController(text: 'Kỹ thuật phần mềm • ĐH Bách Khoa');
  final _passwordController = TextEditingController();
  bool _agreeTerms = true;
  bool _isLoading = false;

  void _handleRegister() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _isLoading = false);
        context.go(AppConstants.routeLibrary);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LlTextField(
          controller: _nameController,
          label: 'Họ và tên của bạn',
          hintText: 'Nguyễn Văn A',
          prefixIcon: const Icon(Icons.person_outline_rounded, size: 20, color: AppColors.primaryContainer),
        ),
        const SizedBox(height: 14),
        LlTextField(
          controller: _emailController,
          label: 'Email trường / cá nhân',
          hintText: 'ten@truong.edu.vn',
          prefixIcon: const Icon(Icons.mail_outline_rounded, size: 20, color: AppColors.primaryContainer),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 14),
        LlTextField(
          controller: _majorController,
          label: 'Chuyên ngành & Trường',
          hintText: 'CNTT • Bách Khoa',
          prefixIcon: const Icon(Icons.school_outlined, size: 20, color: AppColors.primaryContainer),
        ),
        const SizedBox(height: 14),
        LlTextField(
          controller: _passwordController,
          label: 'Mật khẩu',
          hintText: 'Tối thiểu 6 ký tự',
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20, color: AppColors.primaryContainer),
        ),
        const SizedBox(height: 12),
        // Terms Checkbox
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: _agreeTerms,
              activeColor: AppColors.primaryContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              onChanged: (val) => setState(() => _agreeTerms = val ?? false),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Tôi đồng ý với Điều khoản dịch vụ và Chính sách bảo mật của LectureLens.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        LlPrimaryButton(
          text: 'Tạo tài khoản mới 🎒',
          isLoading: _isLoading,
          onPressed: _agreeTerms ? _handleRegister : null,
        ),
      ],
    );
  }
}
