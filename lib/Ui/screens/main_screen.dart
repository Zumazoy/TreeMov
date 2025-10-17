import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../navigation/nav_bar.dart';
import '../calendar/main_calendar.dart';

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
    Center(child: Text('Заглушка профиля', style: TextStyle(fontSize: 20))),
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
