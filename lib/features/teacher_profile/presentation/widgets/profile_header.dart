import 'package:flutter/material.dart';
import 'package:treemov/shared/data/models/org_member_response_model.dart';

import '../../../../core/themes/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final OrgMemberResponseModel orgMember;

  const ProfileHeader({super.key, required this.orgMember});

  String _getFullName() {
    final profile = orgMember.profile;
    if (profile == null) return 'Не указано';

    final parts = [
      profile.surname,
      profile.name,
      profile.patronymic,
    ].where((part) => part != null && part.isNotEmpty).toList();

    return parts.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
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
              child: Icon(
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
                  _getFullName(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                    color: AppColors.notesDarkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ' ',
                  // teacherProfile.teacher?.employee.email ??
                  //     'Заглушка должности',
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
