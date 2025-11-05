import 'package:flutter/material.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/core/widgets/auth/auth_header.dart';

import '../../../../../core/themes/app_colors.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

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
                      'Регистрация',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppColors.white,
                        fontFamily: 'TT Norms',
                      ),
                    ),
                    const SizedBox(height: 40),

                    _buildRoleButton(
                      context,
                      'Ученик',
                      AppRoutes.kidInfoScreen,
                      AppColors.entranceKidButton,
                    ),
                    const SizedBox(height: 20),

                    _buildRoleButton(
                      context,
                      'Преподаватель',
                      AppRoutes.teacherVerificationScreen,
                      AppColors.kidButton,
                    ),
                    const SizedBox(height: 40),

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
                        const SizedBox(height: 2),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.entrance);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Войти',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontFamily: 'TT Norms',
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  AppColors.white, // ← ДОБАВИЛ БЕЛУЮ ЧЕРТОЧКУ
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
    );
  }

  Widget _buildRoleButton(
    BuildContext context,
    String text,
    String route,
    Color buttonColor,
  ) {
    return SizedBox(
      width: 316,
      height: 44,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'TT Norms',
          ),
        ),
      ),
    );
  }
}
