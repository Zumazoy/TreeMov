import 'package:flutter/material.dart';
import 'package:treemov/features/directory/domain/entities/student_entity.dart';
import 'package:treemov/features/directory/presentation/widgets/app_bar_title.dart';
import 'package:treemov/features/directory/presentation/widgets/profile_header.dart';
import 'package:treemov/features/directory/presentation/widgets/profile_info_section.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/layout/nav_bar.dart';

class StudentProfileScreen extends StatelessWidget {
  final StudentEntity student;

  const StudentProfileScreen({super.key, required this.student});

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
          ProfileHeader(student: student),
          const SizedBox(height: 16),
          ProfileInfoSection(student: student),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: onTabTapped,
      ),
    );
  }
}
