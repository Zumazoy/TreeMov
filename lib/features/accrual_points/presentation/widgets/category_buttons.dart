import 'package:flutter/material.dart';
import '../../domain/entities/point_category_entity.dart';
import '../../../../core/themes/app_colors.dart';

class CategoryButtons extends StatelessWidget {
  final PointCategory? selectedCategory;
  final Function(PointCategory) onCategorySelected;

  const CategoryButtons({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildCategoryButton(
                category: PointCategory.participation,
                label: 'Участие',
                iconPath: 'assets/images/team_icon.png',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildCategoryButton(
                category: PointCategory.behavior,
                label: 'Поведение',
                iconPath: 'assets/images/medal_icon.png',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildCategoryButton(
                category: PointCategory.achievements,
                label: 'Достижения',
                iconPath: 'assets/images/achievement_icon.png',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildCategoryButton(
                category: PointCategory.homework,
                label: 'ДЗ',
                iconPath: 'assets/images/home_icon.png',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryButton({
    required PointCategory category,
    required String label,
    required String iconPath,
  }) {
    final isSelected = selectedCategory == category;
    final bgColor = isSelected ? AppColors.teacherPrimary : AppColors.eventTap;
    final textColor = isSelected ? AppColors.white : AppColors.teacherPrimary;
    final iconColor = isSelected ? AppColors.white : AppColors.teacherPrimary;

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.teacherPrimary),
      ),
      child: TextButton(
        onPressed: () => onCategorySelected(category),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 20, height: 20, color: iconColor),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'Arial',
                color: textColor,
                height: 1.0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
