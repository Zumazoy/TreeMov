// lib/features/points/presentation/widgets/category_buttons.dart
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
                category: PointCategory.activity,
                label: 'Участие',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildCategoryButton(
                category: PointCategory.behavior,
                label: 'Поведение',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildCategoryButton(
                category: PointCategory.achievement,
                label: 'Достижения',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildCategoryButton(
                category: PointCategory.homework,
                label: 'ДЗ',
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
  }) {
    final isSelected = selectedCategory == category;
    final bgColor = isSelected ? AppColors.teacherPrimary : AppColors.eventTap;
    final textColor = isSelected ? AppColors.white : AppColors.teacherPrimary;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.teacherPrimary),
      ),
      child: TextButton(
        onPressed: () => onCategorySelected(category),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
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
      ),
    );
  }
}
