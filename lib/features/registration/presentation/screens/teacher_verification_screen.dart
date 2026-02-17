import 'package:flutter/material.dart';
import 'package:treemov/features/registration/presentation/screens/teacher_info_screen.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/auth/auth_header.dart';

class TeacherVerificationScreen extends StatefulWidget {
  const TeacherVerificationScreen({super.key});

  @override
  State<TeacherVerificationScreen> createState() =>
      _TeacherVerificationScreenState();
}

class _TeacherVerificationScreenState extends State<TeacherVerificationScreen> {
  final TextEditingController _teacherCodeController = TextEditingController();
  String? _codeError;

  void _validateCode() {
    setState(() {
      final code = _teacherCodeController.text.trim();
      if (code.isEmpty) {
        _codeError = 'Введите код преподавателя';
      } else if (code.length < 4) {
        _codeError = 'Код должен содержать минимум 4 символа';
      } else {
        _codeError = null;
      }
    });
  }

  bool get _isCodeValid {
    return _codeError == null && _teacherCodeController.text.trim().isNotEmpty;
  }

  void _onNextPressed() {
    _validateCode();
    if (_isCodeValid) {
      final teacherCode = _teacherCodeController.text.trim();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TeacherInfoScreen(teacherCode: teacherCode),
        ),
      );
    }
  }

  @override
  void dispose() {
    _teacherCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      'Код преподавателя',
                      controller: _teacherCodeController,
                      errorText: _codeError,
                      onChanged: (value) {
                        if (_codeError != null) _validateCode();
                      },
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: 316,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: _onNextPressed,
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
    String? errorText,
    void Function(String)? onChanged,
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
            onChanged: onChanged,
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
}
