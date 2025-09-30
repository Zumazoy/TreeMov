import 'package:flutter/material.dart';
import '../navigation/nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Заглушка календаря', style: TextStyle(fontSize: 20))),
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
        backgroundColor: const Color(0xFF75D0FF),
        foregroundColor: Colors.white,
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
