import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/core/widgets/layout/nav_bar.dart';
import 'package:treemov/features/directory/presentation/screens/directory_screen.dart';
import 'package:treemov/features/raiting/presentation/screens/rating_screen.dart';
import 'package:treemov/features/teacher_calendar/presentation/screens/calendar_screen.dart';
import 'package:treemov/features/teacher_profile/presentation/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 3});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    // Получаем DioClient из DI-контейнера
    final dioClient = GetIt.instance<DioClient>();

    _pages = [
      const CalendarScreen(),
      RatingScreen(dioClient: dioClient),
      const DirectoryScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
