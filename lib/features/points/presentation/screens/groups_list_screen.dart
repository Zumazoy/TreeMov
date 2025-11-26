import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../directory/data/mocks/mock_directory_data.dart';
import '../../../directory/domain/entities/group_entity.dart';
import '../widgets/students_points_list_screen.dart';

class GroupsListScreen extends StatelessWidget {
  const GroupsListScreen({super.key});

  void _onGroupTap(GroupEntity group, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentsPointsListScreen(group: group),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Журнал',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.notesDarkText,
            height: 1.0,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Выберите группу для начисления баллов:',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 16,
                color: AppColors.notesDarkText,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: MockDirectoryData.groups.length,
                itemBuilder: (context, index) {
                  final group = MockDirectoryData.groups[index];
                  return _buildGroupItem(context, group);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupItem(BuildContext context, GroupEntity group) {
    return GestureDetector(
      onTap: () => _onGroupTap(group, context),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.directoryBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Группа ${group.name}',
                    style: const TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.notesDarkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${group.studentCount} учеников',
                    style: const TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 14,
                      color: AppColors.directoryTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/purple_arrow.png',
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.directoryTextSecondary,
                  size: 20,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
