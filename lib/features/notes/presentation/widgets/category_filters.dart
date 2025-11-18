import 'package:flutter/material.dart';
import '../../domain/entities/note_category_entity.dart';
import '../../../../core/themes/app_colors.dart';

class CategoryFilters extends StatelessWidget {
  final NoteCategoryEntity selectedCategory;
  final Function(NoteCategoryEntity) onCategorySelected;

  const CategoryFilters({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: NoteCategoryEntity.values.map((category) {
          final isSelected = selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(
                category.title,
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: isSelected
                      ? AppColors.white
                      : AppColors.teacherPrimary,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                onCategorySelected(category);
              },
              selectedColor: AppColors.teacherPrimary,
              backgroundColor: AppColors.eventTap,
              checkmarkColor: AppColors.white,
              side: BorderSide(color: AppColors.teacherPrimary, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          );
        }).toList(),
      ),
    );
  }
}
