import 'package:flutter/material.dart';
import 'package:treemov/core/widgets/layout/nav_bar.dart';
import 'package:treemov/features/accrual_points/presentation/screens/groups_list_screen.dart';
import 'package:treemov/features/directory/presentation/screens/directory_screen.dart';
import 'package:treemov/features/profile/presentation/screens/profile_screen.dart';
import 'package:treemov/features/teacher_calendar/presentation/screens/calendar_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 3});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  final List<Widget> _pages = [
    const CalendarScreen(),
    const GroupsListScreen(),
    const DirectoryScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
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
