import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/teacher_entity.dart';

class ProfileHeader extends StatelessWidget {
  final TeacherEntity teacher;

  const ProfileHeader({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.directoryAvatarBorder,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.directoryAvatarBackground,
              child: teacher.avatarUrl != null
                  ? Image.network(teacher.avatarUrl!)
                  : Icon(
                      Icons.person,
                      size: 32,
                      color: AppColors.teacherPrimary,
                    ),
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teacher.fullName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                    color: AppColors.notesDarkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  teacher.position,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.directoryTextSecondary,
                    fontFamily: 'Arial',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
