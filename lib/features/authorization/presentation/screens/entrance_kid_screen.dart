import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/core/storage/secure_storage_repository.dart';
import 'package:treemov/core/widgets/auth/auth_header.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_repository.dart';
import 'package:treemov/features/authorization/presentation/bloc/login_bloc.dart';

import '../../../../../core/themes/app_colors.dart';

class EntranceKidScreen extends StatefulWidget {
  const EntranceKidScreen({super.key});

  @override
  State<EntranceKidScreen> createState() => _EntranceKidScreenState();
}

class _EntranceKidScreenState extends State<EntranceKidScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kidPrimary,
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
                    _buildTextField('Email', _emailController),
                    const SizedBox(height: 20),
                    _buildPasswordField('Пароль', _passwordController),
                    const SizedBox(height: 20),
                    BlocProvider(
                      create: (context) => LoginBloc(
                        getIt<AuthRepository>(),
                        getIt<SecureStorageRepository>(),
                      ),
                      child: _LoginButton(
                        emailController: _emailController,
                        passwordController: _passwordController,
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
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller) {
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
    String hintText,
    TextEditingController controller,
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

// Отдельный виджет для кнопки с Bloc
class _LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _LoginButton({
    required this.emailController,
    required this.passwordController,
  });

  void _handleLogin(BuildContext context) {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _showErrorSnackbar(context, 'Пожалуйста, заполните все поля');
      return;
    }

    context.read<LoginBloc>().add(
      LoginSubmitted(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.mainApp,
            (route) => false,
          );
        } else if (state is LoginError) {
          _showErrorSnackbar(context, state.error);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SizedBox(
            width: 316,
            height: 44,
            child: ElevatedButton(
              onPressed: state is LoginLoading
                  ? null
                  : () => _handleLogin(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kidButton,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              child: state is LoginLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
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
          );
        },
      ),
    );
  }
}
