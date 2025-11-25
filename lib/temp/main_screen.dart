import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/core/widgets/layout/nav_bar.dart';
import 'package:treemov/features/directory/presentation/screens/directory_screen.dart';
import 'package:treemov/features/notes/presentation/screens/notes_screen.dart';
import 'package:treemov/features/teacher_calendar/presentation/blocs/schedules/schedules_bloc.dart';
import 'package:treemov/features/teacher_calendar/presentation/screens/calendar_screen.dart';
import 'package:treemov/features/profile/presentation/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BlocProvider(
      create: (_) => getIt<SchedulesBloc>(),
      child: const CalendarScreen(),
    ),
    const NotesScreen(), // больше не нужен тут
    const DirectoryScreen(),
    const ProfileScreen(), // замененный профиль
  ];

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
