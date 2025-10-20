import 'package:flutter/material.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/test_home/widgets/nav_button.dart';

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

              NavButton(
                text: 'Экран выбора роли',
                route: AppRoutes.entrance,
                color: Colors.lightBlue,
              ),
              const SizedBox(height: 15),

              NavButton(
                text: 'Экран входа ученика',
                route: AppRoutes.entranceKid,
                color: Colors.green,
              ),
              const SizedBox(height: 15),

              NavButton(
                text: 'Экран преподавателя',
                route: AppRoutes.entranceTeacher,
                color: Colors.orange,
              ),
              const SizedBox(height: 15),

              NavButton(
                text: 'Регистрация ребенка',
                route: AppRoutes.regKid1,
                color: Colors.amber,
              ),
              const SizedBox(height: 15),

              NavButton(
                text: 'Регистрация преподавателя',
                route: AppRoutes.regTeacher1,
                color: Colors.purple,
              ),
              const SizedBox(height: 15),

              NavButton(
                text: 'Тест навигации',
                route: AppRoutes.mainApp,
                color: Colors.red,
              ),
              const SizedBox(height: 15),

              NavButton(
                text: 'Календарь ребенка',
                route: AppRoutes.kidCalendar,
                color: Colors.deepOrangeAccent,
              ),
              const SizedBox(height: 15),

              NavButton(
                text: 'Тест токена',
                route: AppRoutes.testToken,
                color: Colors.indigo,
              ),
              const SizedBox(height: 15),

              NavButton(
                text: 'Тест занятий',
                route: AppRoutes.testSchedule,
                color: Color.fromARGB(255, 158, 201, 41),
              ),
              const SizedBox(height: 15),

              NavButton(
                text: 'Создать занятие',
                route: AppRoutes.createSchedule,
                color: Color.fromARGB(255, 160, 172, 56),
              ),
              const SizedBox(height: 15),

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
}
