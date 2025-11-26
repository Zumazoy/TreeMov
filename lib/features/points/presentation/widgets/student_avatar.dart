import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class StudentAvatar extends StatelessWidget {
  final String? avatarUrl;
  final double size;

  const StudentAvatar({super.key, this.avatarUrl, this.size = 60});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.directoryAvatarBorder, width: 4),
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: CircleAvatar(
        radius: (size - 8) / 2,
        backgroundColor: AppColors.directoryAvatarBackground,
        child: avatarUrl != null
            ? Image.network(avatarUrl!)
            : Icon(
                Icons.person,
                size: size * 0.5,
                color: AppColors.teacherPrimary,
              ),
      ),
    );
  }
}
