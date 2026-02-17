import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/core/widgets/auth/auth_header.dart';
import 'package:treemov/features/registration/domain/repositories/register_repository.dart';
import 'package:treemov/features/registration/presentation/bloc/register_bloc.dart';

import '../../../../../core/themes/app_colors.dart';

class TeacherInfoScreen extends StatefulWidget {
  final String teacherCode;

  const TeacherInfoScreen({super.key, required this.teacherCode});

  @override
  State<TeacherInfoScreen> createState() => _TeacherInfoScreenState();
}

class _TeacherInfoScreenState extends State<TeacherInfoScreen> {
  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateUsername);
    _emailController.addListener(_validateEmail);
    _passwordController1.addListener(_validatePassword);
    _passwordController2.addListener(_validateConfirmPassword);
  }

  void _validateUsername() {
    setState(() {
      if (_usernameController.text.isEmpty) {
        _usernameError = 'Введите имя пользователя';
      } else if (_usernameController.text.length < 3) {
        _usernameError = 'Минимум 3 символа';
      } else {
        _usernameError = null;
      }
    });
  }

  void _validateEmail() {
    setState(() {
      final email = _emailController.text.trim();
      if (email.isEmpty) {
        _emailError = 'Введите email';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        _emailError = 'Введите корректный email';
      } else {
        _emailError = null;
      }
    });
  }

  void _validatePassword() {
    setState(() {
      if (_passwordController1.text.isEmpty) {
        _passwordError = 'Введите пароль';
      } else if (_passwordController1.text.length < 6) {
        _passwordError = 'Пароль должен быть не менее 6 символов';
      } else {
        _passwordError = null;
      }
    });
    _validateConfirmPassword();
  }

  void _validateConfirmPassword() {
    setState(() {
      if (_passwordController2.text.isEmpty) {
        _confirmPasswordError = 'Повторите пароль';
      } else if (_passwordController1.text != _passwordController2.text) {
        _confirmPasswordError = 'Пароли не совпадают';
      } else {
        _confirmPasswordError = null;
      }
    });
  }

  bool get _isFormValid {
    return _usernameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null &&
        _usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController1.text.isNotEmpty &&
        _passwordController2.text.isNotEmpty;
  }

  void _onRegisterPressed(BuildContext context) {
    if (!_isFormValid) return;

    context.read<RegisterBloc>().add(
      RegisterTeacher(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController1.text,
        teacherCode: widget.teacherCode,
      ),
    );
  }

  void _navigateToMain(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.entrance,
      (route) => false,
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController1.dispose();
    _passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(getIt<RegisterRepository>()),
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
                      const SizedBox(height: 180),
                      const Text(
                        'Регистрация',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.white,
                          fontFamily: 'TT Norms',
                        ),
                      ),
                      const SizedBox(height: 40),

                      _buildTextField(
                        'Имя пользователя',
                        _usernameController,
                        errorText: _usernameError,
                      ),
                      const SizedBox(height: 20),

                      _buildTextField(
                        'Электронная почта',
                        _emailController,
                        errorText: _emailError,
                      ),
                      const SizedBox(height: 20),

                      _buildPasswordField(
                        'Придумайте пароль',
                        obscureText: _obscurePassword1,
                        controller: _passwordController1,
                        errorText: _passwordError,
                        onToggle: () {
                          setState(() {
                            _obscurePassword1 = !_obscurePassword1;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      _buildPasswordField(
                        'Повторите пароль',
                        obscureText: _obscurePassword2,
                        controller: _passwordController2,
                        errorText: _confirmPasswordError,
                        onToggle: () {
                          setState(() {
                            _obscurePassword2 = !_obscurePassword2;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterSuccess) {
                            _navigateToMain(context);
                          } else if (state is RegisterError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return SizedBox(
                            width: 316,
                            height: 44,
                            child: ElevatedButton(
                              onPressed:
                                  (state is RegisterLoading || !_isFormValid)
                                  ? null
                                  : () => _onRegisterPressed(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isFormValid
                                    ? AppColors.teacherButton
                                    : AppColors.grey,
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                              ),
                              child: state is RegisterLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: AppColors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Зарегистрироваться',
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

  Widget _buildTextField(
    String hintText,
    TextEditingController controller, {
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 316,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: errorText != null
                ? Border.all(color: Colors.red, width: 1)
                : null,
          ),
          child: TextField(
            controller: controller,
            keyboardType: hintText.contains('почта')
                ? TextInputType.emailAddress
                : TextInputType.text,
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
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 15),
            child: Text(
              errorText,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontFamily: 'TT Norms',
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPasswordField(
    String hintText, {
    required bool obscureText,
    required TextEditingController controller,
    required VoidCallback onToggle,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 316,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: errorText != null
                ? Border.all(color: Colors.red, width: 1)
                : null,
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
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
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.grey,
                ),
                onPressed: onToggle,
              ),
            ),
            style: const TextStyle(fontSize: 16, fontFamily: 'TT Norms'),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 15),
            child: Text(
              errorText,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontFamily: 'TT Norms',
              ),
            ),
          ),
      ],
    );
  }
}
