import 'package:flutter/material.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';
import 'package:treemov/core/widgets/auth/auth_header.dart';

class EntranceScreen extends StatelessWidget {
  const EntranceScreen({super.key});

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

                    Text(
                      'Вход',
                      style: AppTextStyles.ttNorms24W900.white,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    _buildRoleButton(
                      context,
                      'Ученик',
                      AppRoutes.entranceKid,
                      AppColors.entranceKidButton,
                    ),
                    const SizedBox(height: 20),

                    _buildRoleButton(
                      context,
                      'Преподаватель',
                      AppRoutes.entranceTeacher,
                      AppColors.kidButton,
                    ),
                    const SizedBox(height: 40),

                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.registration);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.white,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Зарегистрироваться',
                        style: AppTextStyles.ttNorms16W700.white.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.white,
                          decorationThickness: 1.5,
                        ),
                      ),
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
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Text(text, style: AppTextStyles.ttNorms16W700.white),
      ),
    );
  }
}
