import 'package:flutter/material.dart';

class EntranceScreen extends StatelessWidget {
  const EntranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор роли'),
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
            
            const SizedBox(height: 30),
            
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