import 'package:flutter/material.dart';

class EntranceScreen extends StatelessWidget {
  const EntranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF75D0FF),
      body: Container(
        width: 390,
        height: 844,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Вход',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'TT Norms',
              ),
            ),
            const SizedBox(height: 40),
            
            _buildRoleButton(context, 'Ученик', '/entrance-kid', const Color(0xFF0099E9)),
            const SizedBox(height: 20),
            
            _buildRoleButton(context, 'Преподаватель', '/entrance-teacher', const Color(0xFF004C75)),
            const SizedBox(height: 40),
            
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text(
                'Зарегистрироваться',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'TT Norms',
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String text, String route, Color buttonColor) {
    return SizedBox(
      width: 316,
      height: 44,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'TT Norms',
          ),
        ),
      ),
    );
  }
}