import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

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
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
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
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'TT Norms',
                    color: AppColors.kidButton,
                    height: 1.0,
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
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                      height: 1.0,
                    ),
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
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.statsPinnedText,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
              Text(
                'текущий балл',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.kidButton,
                  height: 1.0,
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
