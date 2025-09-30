import 'package:flutter/material.dart';
import 'ui/entrance_screen.dart';
import 'ui/entrance_kid.dart';
import 'ui/screens/main_screen.dart';
import 'ui/entrance_teacher.dart';
import 'ui/registration/reg_kid1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TreeMov App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/entrance': (context) => const EntranceScreen(),
        '/entrance-kid': (context) => const EntranceKidScreen(),
        '/entrance-teacher': (context) => const EntranceTeacherScreen(),
        '/reg-kid-1': (context) => const RegKid1Screen(),
        '/main-app': (context) => const MainScreen(),
        '/reg-kid-2': (context) => const PlaceholderScreen(title: 'Шаг 2'),
        '/teacher-main-app': (context) => const PlaceholderScreen(title: 'Приложение преподавателя'),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TreeMov - Главная'),
        backgroundColor: const Color(0xFF75D0FF),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Добро пожаловать в TreeMov!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            _buildNavButton(
              context,
              'Экран выбора роли',
              '/entrance',
              Colors.blue,
            ),
            const SizedBox(height: 20),

            _buildNavButton(
              context,
              'Экран входа ученика',
              '/entrance-kid',
              Colors.green,
            ),
            const SizedBox(height: 20),

            _buildNavButton(
              context,
              'Экран преподавателя',
              '/entrance-teacher',
              Colors.orange,
            ),
            const SizedBox(height: 20),

            _buildNavButton(
              context,
              'Регистрация ребенка',
              '/reg-kid-1',
              Colors.amber,
            ),
            const SizedBox(height: 20),

            _buildNavButton(context, 'Тест навигации', '/main-app', Colors.red),
            const SizedBox(height: 20),

            const Text(
              'Это тестовые кнопки',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    String text,
    String route,
    Color color,
  ) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF75D0FF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('В процессе'),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              },
              child: const Text('Вернуться на главную'),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/main-app',
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Перейти в приложение (навигация)'),
            ),
          ],
        ),
      ),
    );
  }
}
