import 'package:flutter/material.dart';
import 'package:treemov/Ui/test_token_screen.dart';
import 'package:treemov/bloc/providers.dart';

import 'constants/app_colors.dart';
import 'constants/app_routes.dart';
import 'ui/entrance/entrance_kid.dart';
import 'ui/entrance/entrance_screen.dart';
import 'ui/entrance/entrance_teacher.dart';
import 'ui/registration/reg_kid1.dart';
import 'ui/registration/reg_kid2.dart';
import 'ui/registration/reg_teacher1.dart';
import 'ui/registration/reg_teacher2.dart';
import 'ui/screens/main_screen.dart';
import 'ui/test_schedule.dart';

void main() {
  // Инициализируем зависимости
  setupDependencies();

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
        AppRoutes.entrance: (context) => const EntranceScreen(),
        AppRoutes.entranceKid: (context) => const EntranceKidScreen(),
        AppRoutes.entranceTeacher: (context) => const EntranceTeacherScreen(),
        AppRoutes.regKid1: (context) => const RegKid1Screen(),
        AppRoutes.regKid2: (context) => const RegKid2Screen(),
        AppRoutes.regTeacher1: (context) => const RegTeacher1Screen(),
        AppRoutes.regTeacher2: (context) => const RegTeacher2Screen(),
        AppRoutes.mainApp: (context) => const MainScreen(),
        '/test_token': (context) => TokenTestScreen(),
        '/test_schedule': (context) => TestScheduleScreen(),
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
        backgroundColor: AppColors.kidPrimary,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Добро пожаловать в TreeMov!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              _buildNavButton(
                context,
                'Экран выбора роли',
                AppRoutes.entrance,
                Colors.lightBlue,
              ),
              const SizedBox(height: 15),

              _buildNavButton(
                context,
                'Экран входа ученика',
                AppRoutes.entranceKid,
                Colors.green,
              ),
              const SizedBox(height: 15),

              _buildNavButton(
                context,
                'Экран преподавателя',
                AppRoutes.entranceTeacher,
                Colors.orange,
              ),
              const SizedBox(height: 15),

              _buildNavButton(
                context,
                'Регистрация ребенка',
                AppRoutes.regKid1,
                Colors.amber,
              ),
              const SizedBox(height: 15),

              _buildNavButton(
                context,
                'Регистрация преподавателя',
                AppRoutes.regTeacher1,
                Colors.purple,
              ),
              const SizedBox(height: 15),

              _buildNavButton(
                context,
                'Тест навигации',
                AppRoutes.mainApp,
                Colors.red,
              ),
              const SizedBox(height: 15),

              _buildNavButton(
                context,
                'Календарь v0.1',
                '/calendar',
                Colors.deepOrangeAccent,
              ),
              const SizedBox(height: 15),

              _buildNavButton(
                context,
                'Тест токена',
                '/test_token',
                Colors.indigo,
              ),
              const SizedBox(height: 30),

              _buildNavButton(
                context,
                'Тест занятий',
                '/test_schedule',
                const Color.fromARGB(255, 158, 201, 41),
              ),
              const SizedBox(height: 30),

              const Text(
                'Это тестовые кнопки',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
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
      width: 280,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
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
                  AppRoutes.mainApp,
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
