import 'package:flutter/material.dart';

class EntranceTeacherScreen extends StatelessWidget {
  const EntranceTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход преподавателя'),
        backgroundColor: const Color(0xFF7A75FF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFF7A75FF),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                color: Colors.white,
                fontFamily: 'TT Norms',
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Вход',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontFamily: 'TT Norms',
              ),
            ),
            const SizedBox(height: 30),

            _buildTextField('email', Icons.email_outlined),
            const SizedBox(height: 20),

            _buildTextField('Пароль', Icons.lock_outline, isPassword: true),
            const SizedBox(height: 30),

            SizedBox(
              width: 316,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context, 
                    '/teacher-main-app', 
                    (route) => false
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5C57CC),
                  foregroundColor: Colors.white,
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
            
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  '/home', 
                  (route) => false
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF7A75FF),
              ),
              child: const Text('На главную'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon, {bool isPassword = false}) {
    return Container(
      width: 316,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: 'TT Norms',
          ),
          prefixIcon: Icon(icon, color: Colors.grey),
        ),
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'TT Norms',
        ),
      ),
    );
  }
}