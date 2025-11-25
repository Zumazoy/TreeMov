import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

enum ReportFilterCategory {
  performance('Успеваемость', 4),
  attendance('Посещаемость', 4),
  rating('Баллы', 2),
  other('Другое', 24);

  final String title;
  final int mockCount;

  const ReportFilterCategory(this.title, this.mockCount);
}

class ReportFilterCategoriesSection extends StatelessWidget {
  final ReportFilterCategory? selectedCategory;
  final Function(ReportFilterCategory) onCategorySelected;

  const ReportFilterCategoriesSection({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<ReportFilterCategory> _categories = ReportFilterCategory.values;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Категория:',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.0,
            color: AppColors.directoryTextSecondary,
          ),
        ),
        const SizedBox(height: 12),

        ..._categories.map((category) {
          return Column(
            children: [
              _ReportCategoryItem(
                category: category,
                isSelected: selectedCategory == category,
                onSelected: () => onCategorySelected(category),
              ),
              if (_categories.indexOf(category) < _categories.length - 1)
                const SizedBox(height: 8),
            ],
          );
        }).toList(),
      ],
    );
  }
}

class _ReportCategoryItem extends StatelessWidget {
  final ReportFilterCategory category;
  final bool isSelected;
  final VoidCallback onSelected;

  const _ReportCategoryItem({
    required this.category,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.eventTap : AppColors.white,
          border: Border.all(
            color: isSelected ? AppColors.teacherPrimary : AppColors.eventTap,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                category.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.notesDarkText,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                category.mockCount.toString(),
                style: const TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.notesDarkText,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Радио-кнопка
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.teacherPrimary
                      : AppColors.directoryTextSecondary,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.circle,
                        size: 10,
                        color: AppColors.teacherPrimary,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
