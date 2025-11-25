import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/teacher_note_entity.dart';

class FilterQuickSection extends StatelessWidget {
  final String? selectedFilter;
  final Function(String) onFilterToggled;
  final List<TeacherNoteEntity> allNotes;

  FilterQuickSection({
    super.key,
    required this.selectedFilter,
    required this.onFilterToggled,
    required this.allNotes,
  });

  final List<String> _quickFilterOptions = [
    'Эта неделя',
    'Месяц',
    'Закрепленные',
  ];

  int _getNotesCountForFilter(String filter) {
    final now = DateTime.now();
    switch (filter) {
      case 'Эта неделя':
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        return allNotes
            .where(
              (note) => note.date.isAfter(
                startOfWeek.subtract(const Duration(days: 1)),
              ),
            )
            .length;
      case 'Месяц':
        final startOfMonth = DateTime(now.year, now.month, 1);
        return allNotes
            .where(
              (note) => note.date.isAfter(
                startOfMonth.subtract(const Duration(days: 1)),
              ),
            )
            .length;
      case 'Закрепленные':
        return allNotes.where((note) => note.isPinned).length;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Быстрый фильтр:',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.0,
            color: AppColors.directoryTextSecondary,
          ),
        ),

        const SizedBox(height: 12),

        ..._quickFilterOptions.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          return Column(
            children: [
              _QuickFilterItem(
                option: option,
                isSelected: selectedFilter == option,
                notesCount: _getNotesCountForFilter(option),
                onToggled: () => onFilterToggled(option),
              ),
              if (index < _quickFilterOptions.length - 1)
                const SizedBox(height: 8),
            ],
          );
        }),
      ],
    );
  }
}

class _QuickFilterItem extends StatelessWidget {
  final String option;
  final bool isSelected;
  final int notesCount;
  final VoidCallback onToggled;

  const _QuickFilterItem({
    required this.option,
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
              option,
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
