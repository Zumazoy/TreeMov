import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_repository.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_storage_repository.dart';
import 'package:treemov/features/authorization/presentation/blocs/token/token_bloc.dart';

class EntranceTeacherScreen extends StatelessWidget {
  const EntranceTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TokenBloc(
        authRepository: getIt<AuthRepository>(),
        authStorageRepository: getIt<AuthStorageRepository>(),
      ),
      child: BlocListener<TokenBloc, TokenState>(
        listener: (context, state) {
          if (state is TokenSuccess) {
            // Успешная авторизация
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.mainApp,
              (route) => false,
            );
          } else if (state is TokenError) {
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

    context.read<TokenBloc>().add(
      GetTokenEvent(username: email, password: password),
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
    return BlocListener<TokenBloc, TokenState>(
      listener: (context, state) {
        if (state is TokenLoading) {
          setState(() => _isLoading = true);
        } else if (state is TokenError || state is TokenSuccess) {
          setState(() => _isLoading = false);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.teacherPrimary,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/white_default_logo.png',
                    width: 48.56,
                    height: 47.24,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'TreeMov',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontFamily: 'TT Norms',
                    ),
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    'Вход',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.white,
                      fontFamily: 'TT Norms',
                    ),
                  ),
                  const SizedBox(height: 30),

                  _buildTextField(_emailController, 'email'),
                  const SizedBox(height: 20),

                  _buildTextField(
                    _passwordController,
                    'Пароль',
                    isPassword: true,
                  ),
                  const SizedBox(height: 30),

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
                                fontWeight: FontWeight.w500,
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
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText, {
    bool isPassword = false,
  }) {
    return Container(
      width: 316,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
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
}
