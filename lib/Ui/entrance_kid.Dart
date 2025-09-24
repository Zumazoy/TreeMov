import 'package:flutter/material.dart';

class EntranceKidScreen extends StatelessWidget {
  const EntranceKidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход ученика'),
        backgroundColor: const Color(0xFF75D0FF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFF75D0FF),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TreeMov',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'TT Norms',
              ),
            ),
            const SizedBox(height: 20),

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
                    '/main-app', 
                    (route) => false
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0099E9),
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
                foregroundColor: const Color(0xFF75D0FF),
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