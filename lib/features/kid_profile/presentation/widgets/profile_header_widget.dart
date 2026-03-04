import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final int level;
  final String levelTitle;
  final int currentPoints;
  final String? avatarUrl;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.level,
    required this.levelTitle,
    required this.currentPoints,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: AppColors.teacherPrimary.withAlpha(51),
            backgroundImage: avatarUrl != null
                ? NetworkImage(avatarUrl!)
                : null,
            child: avatarUrl == null
                ? Text(
                    _getInitials(name),
                    style: AppTextStyles.ttNorms20W900.copyWith(
                      color: AppColors.teacherPrimary,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.ttNorms14W900.copyWith(
                    color: AppColors.kidButton,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.entranceKidButton,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Уровень $level · $levelTitle',
                    style: AppTextStyles.ttNorms11W400.white,
                  ),
                ),
              ],
            ),
          ),

          Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/energy_icon.png',
                    width: 24,
                    height: 24,
                    color: AppColors.statsPinnedText,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    currentPoints.toString(),
                    style: AppTextStyles.ttNorms24W900.copyWith(
                      color: AppColors.statsPinnedText,
                    ),
                  ),
                ],
              ),
              Text(
                'текущий балл',
                style: AppTextStyles.ttNorms11W400.copyWith(
                  color: AppColors.kidButton,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getInitials(String fullName) {
    List<String> nameParts = fullName.trim().split(' ');
    if (nameParts.isEmpty) return '?';
    if (nameParts.length == 1) return nameParts[0][0].toUpperCase();
    return (nameParts[0][0] + nameParts[1][0]).toUpperCase();
  }
}
