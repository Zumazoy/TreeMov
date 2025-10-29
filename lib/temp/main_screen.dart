import 'package:flutter/material.dart';
import 'package:treemov/core/widgets/layout/nav_bar.dart';
import 'package:treemov/features/teacher_calendar/presentation/screens/calendar_screen.dart';
import 'package:treemov/temp/profile_screen.dart';

import '../core/themes/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CalendarScreen(),
    Center(child: Text('Заглушка рейтинга', style: TextStyle(fontSize: 20))),
    Center(child: Text('Заглушка магазина', style: TextStyle(fontSize: 20))),
    const ProfileScreen(),
  ];

  final List<String> _pageTitles = [
    'Календарь',
    'Рейтинг',
    'Магазин',
    'Профиль',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_currentIndex]),
        backgroundColor: AppColors.teacherPrimary,
        foregroundColor: AppColors.white,
      ),

      body: _pages[_currentIndex],

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
