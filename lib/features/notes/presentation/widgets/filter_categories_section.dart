import 'package:flutter/material.dart';
import '../../domain/entities/note_category_entity.dart';
import '../../domain/entities/teacher_note_entity.dart';
import '../../../../core/themes/app_colors.dart';

class FilterCategoriesSection extends StatelessWidget {
  final List<NoteCategoryEntity> selectedCategories;
  final Function(NoteCategoryEntity) onCategoryToggled;
  final List<TeacherNoteEntity> allNotes;

  FilterCategoriesSection({
    super.key,
    required this.selectedCategories,
    required this.onCategoryToggled,
    required this.allNotes,
  });

  final List<NoteCategoryEntity> _categories = [
    NoteCategoryEntity.behavior,
    NoteCategoryEntity.study,
    NoteCategoryEntity.parents,
    NoteCategoryEntity.general,
  ];

  int _getNotesCountForCategory(NoteCategoryEntity category) {
    return allNotes.where((note) => note.category == category).length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
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
              _CategoryItem(
                category: category,
                isSelected: selectedCategories.contains(category),
                notesCount: _getNotesCountForCategory(category),
                onToggled: () => onCategoryToggled(category),
              ),
              if (_categories.indexOf(category) < _categories.length - 1)
                const SizedBox(height: 8),
            ],
          );
        }),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final NoteCategoryEntity category;
  final bool isSelected;
  final int notesCount;
  final VoidCallback onToggled;

  const _CategoryItem({
    required this.category,
    required this.isSelected,
    required this.notesCount,
    required this.onToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.eventTap),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              category.title,
              style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                height: 1.0,
                color: AppColors.notesDarkText,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.eventTap,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              notesCount.toString(),
              style: const TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColors.notesDarkText,
              ),
            ),
          ),

          const SizedBox(width: 10),

          GestureDetector(
            onTap: onToggled,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.notesDarkText
                      : AppColors.directoryTextSecondary,
                  width: isSelected ? 6 : 2,
                ),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
