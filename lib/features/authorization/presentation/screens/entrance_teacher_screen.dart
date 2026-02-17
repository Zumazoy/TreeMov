import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/core/widgets/auth/auth_header.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_repository.dart';
import 'package:treemov/features/authorization/presentation/bloc/login_bloc.dart';
import 'package:treemov/shared/storage/domain/repositories/secure_storage_repository.dart';

import '../../../../../core/themes/app_colors.dart';

class EntranceTeacherScreen extends StatelessWidget {
  const EntranceTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(getIt<AuthRepository>(), getIt<SecureStorageRepository>()),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // Успешная авторизация
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.mainApp,
              (route) => false,
            );
          } else if (state is LoginError) {
            // Показ ошибки авторизации
            _showErrorDialog(context, state.error);
          }
        },
        child: const _EntranceTeacherContent(),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          'Ошибка входа',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.teacherPrimary,
            fontFamily: 'TT Norms',
          ),
        ),
        content: Text(
          _parseError(error),
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.grey,
            fontFamily: 'TT Norms',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(
                color: AppColors.teacherPrimary,
                fontSize: 16,
                fontFamily: 'TT Norms',
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _parseError(String error) {
    if (error.contains('No active account found with the given credentials')) {
      return 'Неверный email или пароль. Проверьте введенные данные.';
    } else {
      return error;
    }
  }
}

class _EntranceTeacherContent extends StatefulWidget {
  const _EntranceTeacherContent();

  @override
  State<_EntranceTeacherContent> createState() =>
      _EntranceTeacherContentState();
}

class _EntranceTeacherContentState extends State<_EntranceTeacherContent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showValidationError();
      return;
    }

    setState(() => _isLoading = true);

    context.read<LoginBloc>().add(
      LoginSubmitted(email: email, password: password),
    );
  }

  void _showValidationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.teacherPrimary,
        content: const Text(
          'Заполните все поля',
          style: TextStyle(fontFamily: 'TT Norms'),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          setState(() => _isLoading = true);
        } else if (state is LoginError || state is LoginSuccess) {
          setState(() => _isLoading = false);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.teacherPrimary,
        body: Stack(
          children: [
            const AuthHeader(),

            Center(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),

                      const Text(
                        'Вход',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.white,
                          fontFamily: 'TT Norms',
                        ),
                      ),
                      const SizedBox(height: 40),

                      _buildTextField(_emailController, 'email'),
                      const SizedBox(height: 20),

                      _buildPasswordField(_passwordController, 'Пароль'),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: 316,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.teacherButton,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Войти',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'TT Norms',
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Container(
      width: 316,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 12,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.grey,
            fontSize: 16,
            fontFamily: 'TT Norms',
          ),
        ),
        style: const TextStyle(fontSize: 16, fontFamily: 'TT Norms'),
      ),
    );
  }

  Widget _buildPasswordField(
    TextEditingController controller,
    String hintText,
  ) {
    return Container(
      width: 316,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 12,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.grey,
            fontSize: 16,
            fontFamily: 'TT Norms',
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: AppColors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        style: const TextStyle(fontSize: 16, fontFamily: 'TT Norms'),
      ),
    );
  }
}
