import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';

class StudentAvatar extends StatelessWidget {
  final String? avatarUrl;
  final double size;

  const StudentAvatar({super.key, this.avatarUrl, this.size = 60});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.directoryAvatarBackground,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.directoryAvatarBorder, width: 2),
      ),
      child: avatarUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                avatarUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person,
                    color: AppColors.directoryTextSecondary,
                    size: 28,
                  );
                },
              ),
            )
          : const Icon(
              Icons.person,
              color: AppColors.directoryTextSecondary,
              size: 28,
            ),
    );
  }
}
