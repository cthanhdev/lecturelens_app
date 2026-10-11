import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/ll_primary_button.dart';
import '../../../../shared/widgets/inputs/ll_text_field.dart';

/// Form Đăng Nhập
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'student@lecturelens.edu.vn');
  final _passwordController = TextEditingController(text: 'password123');
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _handleLogin() {
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LlTextField(
            controller: _emailController,
            label: 'Email sinh viên',
            hintText: 'vidu@sinhvien.edu.vn',
            prefixIcon: const Icon(Icons.mail_outline_rounded, size: 20, color: AppColors.primaryContainer),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          LlTextField(
            controller: _passwordController,
            label: 'Mật khẩu',
            hintText: 'Nhập mật khẩu của bạn',
            obscureText: _obscurePassword,
            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20, color: AppColors.primaryContainer),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20,
                color: AppColors.onSurfaceVariant,
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Quên mật khẩu?',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          LlPrimaryButton(
            text: 'Đăng nhập vào bàn học →',
            isLoading: _isLoading,
            onPressed: _handleLogin,
          ),
        ],
      ),
    );
  }
}
