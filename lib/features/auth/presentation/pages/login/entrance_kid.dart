import 'package:flutter/material.dart';
import 'package:treemov/app/routes/app_routes.dart';

import '../../../../../core/themes/app_colors.dart';

class EntranceKidScreen extends StatelessWidget {
  const EntranceKidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход ученика'),
        backgroundColor: AppColors.kidPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.kidPrimary,
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
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                    fontFamily: 'TT Norms',
                  ),
                ),
                const SizedBox(height: 30),

                _buildTextField('Email'),
                const SizedBox(height: 20),

                _buildTextField('Пароль', isPassword: true),
                const SizedBox(height: 30),

                SizedBox(
                  width: 316,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.mainApp,
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kidButton,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
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
    );
  }

  Widget _buildTextField(String hintText, {bool isPassword = false}) {
    return Container(
      width: 316,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
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
