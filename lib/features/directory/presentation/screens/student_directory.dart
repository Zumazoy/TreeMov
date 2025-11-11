import 'package:flutter/material.dart';
import 'package:treemov/features/directory/data/mocks/mock_directory_data.dart';
import 'package:treemov/features/directory/domain/entities/student_entity.dart';
import 'package:treemov/features/directory/presentation/screens/student_profile.dart';
import 'package:treemov/features/directory/presentation/widgets/app_bar_title.dart';
import 'package:treemov/features/directory/presentation/widgets/search_field.dart';
import 'package:treemov/features/directory/presentation/widgets/student_item.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/layout/nav_bar.dart';

class StudentDirectoryScreen extends StatefulWidget {
  final String groupName;
  final String subjectName;

  const StudentDirectoryScreen({
    super.key,
    required this.groupName,
    required this.subjectName,
  });

  @override
  State<StudentDirectoryScreen> createState() => _StudentDirectoryScreenState();
}

class _StudentDirectoryScreenState extends State<StudentDirectoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<StudentEntity> _filteredStudents = [];

  @override
  void initState() {
    super.initState();
    _filteredStudents = MockDirectoryData.students;
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredStudents = MockDirectoryData.students;
      } else {
        _filteredStudents = MockDirectoryData.students.where((student) {
          return student.fullName.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _onStudentTap(StudentEntity student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentProfileScreen(student: student),
      ),
    );
  }

  void _onTabTapped(int index) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: AppBarTitle(text: 'Ученики ${widget.groupName}'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.grayFieldText,
        elevation: 0,
      ),
      body: Column(
        children: [
          SearchField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            hintText: 'Найти: по группам, ученикам...',
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ..._filteredStudents.map(
                  (student) => StudentItem(
                    student: student,
                    groupName: widget.groupName,
                    onTap: () => _onStudentTap(student),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: _onTabTapped,
      ),
    );
  }
}
