import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/point_category_entity.dart';
import '../../data/mocks/mock_points_data.dart';

class PointsSnackBar {
  static void show({
    required BuildContext context,
    required StudentWithPoints student,
    required PointAction action,
  }) {
    final isPositive = action.points > 0;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${isPositive ? 'Начислено' : 'Списано'} ${action.points.abs()} баллов',
          style: const TextStyle(
            fontFamily: 'Arial',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: isPositive
            ? AppColors.teacherPrimary
            : const Color(0xFFDC2626),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
