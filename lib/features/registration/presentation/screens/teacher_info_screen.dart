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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _passwordController1.addListener(_validatePasswords);
    _passwordController2.addListener(_validatePasswords);
  }

  void _validatePasswords() {
    setState(() {
      if (_passwordController1.text.isEmpty ||
          _passwordController2.text.isEmpty) {
        _passwordError = null;
      } else if (_passwordController1.text != _passwordController2.text) {
        _passwordError = 'Пароли не совпадают';
      } else {
        _passwordError = null;
      }
    });
  }

  void _onRegisterPressed(BuildContext context) {
    if (_passwordError != null) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController1.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Заполните все поля'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<RegisterBloc>().add(
      RegisterTeacher(
        username: name,
        email: email,
        password: password,
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
    _nameController.dispose();
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

                      _buildTextField('ФИО', controller: _nameController),
                      const SizedBox(height: 20),

                      _buildTextField('Email', controller: _emailController),
                      const SizedBox(height: 20),

                      _buildPasswordField(
                        'Придумайте пароль',
                        obscureText: _obscurePassword1,
                        controller: _passwordController1,
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
                        onToggle: () {
                          setState(() {
                            _obscurePassword2 = !_obscurePassword2;
                          });
                        },
                      ),

                      if (_passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _passwordError!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontFamily: 'TT Norms',
                            ),
                          ),
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
                              onPressed: state is RegisterLoading
                                  ? null
                                  : () => _onRegisterPressed(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.teacherButton,
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
    String hintText, {
    required TextEditingController controller,
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
    String hintText, {
    required bool obscureText,
    required TextEditingController controller,
    required VoidCallback onToggle,
  }) {
    return Container(
      width: 316,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: _passwordError != null
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
    );
  }
}
