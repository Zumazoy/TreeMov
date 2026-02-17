import 'package:flutter/material.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/core/widgets/auth/auth_header.dart';

import '../../../../../core/themes/app_colors.dart';

class KidInfoScreen extends StatefulWidget {
  const KidInfoScreen({super.key});

  @override
  State<KidInfoScreen> createState() => _KidInfoScreenState();
}

class _KidInfoScreenState extends State<KidInfoScreen> {
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

  void _onNextPressed() {
    if (!_isFormValid) return;

    final registrationData = {
      'username': _usernameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController1.text,
    };

    Navigator.pushNamed(
      context,
      AppRoutes.parentInfoScreen,
      arguments: registrationData,
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

                    SizedBox(
                      width: 316,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: _isFormValid ? _onNextPressed : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isFormValid
                              ? AppColors.kidButton
                              : AppColors.grey,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Далее →',
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
