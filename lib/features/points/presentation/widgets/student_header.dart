import 'package:flutter/material.dart';
import '../widgets/student_avatar.dart';
import '../../../../core/themes/app_colors.dart';
import '../../data/mocks/mock_points_data.dart';

class StudentHeader extends StatelessWidget {
  final StudentWithPoints student;
  final VoidCallback onClose;

  const StudentHeader({
    super.key,
    required this.student,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.eventTap, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          StudentAvatar(avatarUrl: student.avatarUrl, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.fullName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w700,
                    color: AppColors.notesDarkText,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/energy_icon.png',
                      width: 16,
                      height: 16,
                      color: AppColors.directoryTextSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${student.totalPoints} баллов',
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        color: AppColors.directoryTextSecondary,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: Icon(Icons.close, size: 24, color: AppColors.teacherPrimary),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}
