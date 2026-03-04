import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

import '../../domain/entities/point_category_entity.dart';

class PointsSnackBar {
  static void show({
    required BuildContext context,
    required StudentEntity student,
    required PointAction action,
  }) {
    final isPositive = action.points > 0;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${isPositive ? 'Начислено' : 'Списано'} ${action.points.abs()} баллов',
          style: AppTextStyles.arial14W500.white,
        ),
        backgroundColor: isPositive
            ? AppColors.teacherPrimary
            : AppColors.activityRed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
