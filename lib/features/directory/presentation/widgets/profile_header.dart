import 'package:flutter/material.dart';
import 'package:treemov/features/directory/data/mocks/mock_directory_data.dart';
import 'package:treemov/features/directory/domain/entities/group_entity.dart';
import 'package:treemov/features/directory/domain/entities/student_entity.dart';

import '../../../../../core/themes/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final StudentEntity student;

  const ProfileHeader({super.key, required this.student});

  String _getGroupName(String groupId) {
    final group = MockDirectoryData.groups.firstWhere(
      (g) => g.id == groupId,
      orElse: () => GroupEntity(
        id: '',
        name: 'Неизвестно',
        subjectId: '',
        studentCount: 0,
      ),
    );
    return group.name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.eventTap,
        border: Border.all(color: AppColors.eventTap),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.fullName,
                  style: const TextStyle(
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    height: 1.0,
                    color: AppColors.grayFieldText,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Группа: ',
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.0,
                          color: AppColors.directoryTextSecondary,
                        ),
                      ),
                      TextSpan(
                        text: _getGroupName(student.currentGroupId),
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.0,
                          color: AppColors.grayFieldText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Почта: ',
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.0,
                          color: AppColors.directoryTextSecondary,
                        ),
                      ),
                      TextSpan(
                        text: student.email,
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.0,
                          color: AppColors.grayFieldText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Дата присоединения к группе: ',
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.0,
                          color: AppColors.directoryTextSecondary,
                        ),
                      ),
                      TextSpan(
                        text: student.formattedGroupJoinDate,
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.0,
                          color: AppColors.grayFieldText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Аватарка
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.directoryAvatarBackground,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: AppColors.directoryAvatarBorder,
                width: 4,
              ),
            ),
            child: student.avatarUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(46),
                    child: Image.network(student.avatarUrl!, fit: BoxFit.cover),
                  )
                : const Icon(
                    Icons.person,
                    color: AppColors.directoryTextSecondary,
                    size: 50,
                  ),
          ),
        ],
      ),
    );
  }
}
