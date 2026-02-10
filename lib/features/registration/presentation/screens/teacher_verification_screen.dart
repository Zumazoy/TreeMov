import 'package:flutter/material.dart';
import 'package:treemov/features/registration/presentation/screens/teacher_info_screen.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/auth/auth_header.dart';

class TeacherVerificationScreen extends StatelessWidget {
  const TeacherVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teacherCodeController = TextEditingController();

    return Scaffold(
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
                      'Код преподавателя',
                      controller: teacherCodeController,
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: 316,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          final teacherCode = teacherCodeController.text.trim();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TeacherInfoScreen(teacherCode: teacherCode),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.teacherButton,
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
}
