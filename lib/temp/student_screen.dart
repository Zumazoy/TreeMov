import 'package:flutter/material.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/core/storage/secure_storage_repository_impl.dart';
import 'package:treemov/core/widgets/layout/child_nav_bar.dart';
import 'package:treemov/features/kid_calendar/presentation/screens/calendar_kid.dart';
import 'package:treemov/features/kid_profile/presentation/screens/student_profile_screen.dart';
import 'package:treemov/features/raiting/presentation/screens/rating_screen.dart';
import 'package:treemov/temp/directory_placeholder.dart';

class StudentScreen extends StatefulWidget {
  final int initialIndex;

  const StudentScreen({super.key, this.initialIndex = 3});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  late int _currentIndex;
  late final DioClient _dioClient;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _dioClient = DioClient(secureStorage: SecureStorageRepositoryImpl());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const CalendarKidScreen(),
          RatingScreen(dioClient: _dioClient),
          const DirectoryPlaceholder(),
          const StudentProfileScreen(),
        ],
      ),
      bottomNavigationBar: ChildBottomNavigationBar(
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
