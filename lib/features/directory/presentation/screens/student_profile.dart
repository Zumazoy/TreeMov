import 'package:flutter/material.dart';
import 'package:treemov/features/directory/presentation/widgets/app_bar_title.dart';
import 'package:treemov/features/directory/presentation/widgets/profile_header.dart';
import 'package:treemov/features/directory/presentation/widgets/profile_info_section.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/layout/nav_bar.dart';

class StudentProfileScreen extends StatelessWidget {
  final StudentEntity student;
  final String groupName;
  final List<StudentGroupResponseModel> allGroups;

  const StudentProfileScreen({
    super.key,
    required this.student,
    required this.groupName,
    required this.allGroups,
  });

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      Navigator.popUntil(context, (route) => route.isFirst);
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const AppBarTitle(text: 'Профиль'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.grayFieldText,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ProfileHeader(student: student, groupName: groupName),
          const SizedBox(height: 16),
          ProfileInfoSection(
            student: student,
            allGroups: allGroups,
            currentGroupName: groupName,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: onTabTapped,
      ),
    );
  }
}
