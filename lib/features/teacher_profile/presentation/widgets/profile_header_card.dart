import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/shared/data/models/teacher_profile_response_model.dart';

class ProfileHeaderCard extends StatelessWidget {
  final TeacherProfileResponseModel? teacherProfile;

  const ProfileHeaderCard({super.key, required this.teacherProfile});

  String _getFullName() {
    if (teacherProfile == null) {
      return 'Профиль null';
    }
    final employer = teacherProfile!.teacher?.employer;
    if (employer == null) return 'Не указано';

    final parts = [
      employer.surname,
      employer.name,
      employer.patronymic,
    ].where((part) => part != null && part.isNotEmpty).toList();

    return parts.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.teacherPrimary.withAlpha(51),
              border: Border.all(color: AppColors.teacherPrimary, width: 1.5),
            ),
            child: CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.directoryAvatarBackground,
              child: teacherProfile != null
                  ? teacherProfile!.teacher?.employer.inn != null
                        ? Image.network(teacherProfile!.teacher!.employer.inn!)
                        : Icon(
                            Icons.person,
                            size: 32,
                            color: AppColors.teacherPrimary,
                          )
                  : Icon(
                      Icons.person,
                      size: 32,
                      color: AppColors.teacherPrimary,
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getFullName(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.notesDarkText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                teacherProfile != null
                    ? teacherProfile!.teacher?.employer.email ??
                          'Заглушка должности'
                    : 'Профиль null',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.directoryTextSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
