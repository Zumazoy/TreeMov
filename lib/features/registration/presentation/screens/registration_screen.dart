import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/auth/auth_header.dart';
import '../../../../shared/presentation/widgets/app_primary_button.dart';
import '../../../../shared/presentation/widgets/app_text_field.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';
import 'verification_code_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kidPrimary,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterCodeSent) {
            final registerBloc = context.read<RegisterBloc>();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: registerBloc,
                  child: const VerificationCodeScreen(),
                ),
              ),
            );
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        child: Stack(
          children: [
            const AuthHeader(),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      const Text(
                        'Регистрация',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.white,
                          fontFamily: 'TT Norms',
                        ),
                      ),
                      const SizedBox(height: 30),

                      AppTextField(
                        controller: _usernameController,
                        hintText: "Имя пользователя",
                        fillColor: AppColors.white,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: _emailController,
                        hintText: "Email",
                        fillColor: AppColors.white,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: _passwordController,
                        hintText: "Пароль",
                        obscureText: true,
                        fillColor: AppColors.white,
                      ),
                      const SizedBox(height: 24),

                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          if (state is RegisterLoading) {
                            return const CircularProgressIndicator(
                              color: Colors.white,
                            );
                          }
                          return SizedBox(
                            width: double.infinity,
                            child: AppPrimaryButton(
                              text: "Зарегистрироваться",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<RegisterBloc>().add(
                                    SubmitRegistrationEvent(
                                      username: _usernameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // Кнопка "Войти"
                      Column(
                        children: [
                          const Text(
                            'Есть аккаунт?',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontFamily: 'TT Norms',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.entranceKid,
                              );
                            },
                            child: const Text(
                              'Войти',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontFamily: 'TT Norms',
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
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
}
