import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

enum ReportQuickFilter {
  thisWeek('Эта неделя', 2),
  thisMonth('Месяц', 14);

  final String title;
  final int mockCount;

  const ReportQuickFilter(this.title, this.mockCount);
}

class ReportFilterQuickSection extends StatelessWidget {
  final ReportQuickFilter? selectedFilter;
  final Function(ReportQuickFilter) onFilterSelected;

  const ReportFilterQuickSection({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final List<ReportQuickFilter> _filters = ReportQuickFilter.values;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
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

        ..._filters.map((filter) {
          return Column(
            children: [
              _ReportQuickFilterItem(
                filter: filter,
                isSelected: selectedFilter == filter,
                onSelected: () => onFilterSelected(filter),
              ),
              if (_filters.indexOf(filter) < _filters.length - 1)
                const SizedBox(height: 8),
            ],
          );
        }),
      ],
    );
  }
}

class _ReportQuickFilterItem extends StatelessWidget {
  final ReportQuickFilter filter;
  final bool isSelected;
  final VoidCallback onSelected;

  const _ReportQuickFilterItem({
    required this.filter,
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
                filter.title,
                style: const TextStyle(
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
              child: Text(
                filter.mockCount.toString(),
                style: const TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.notesDarkText,
                ),
              ),
            ),
            const SizedBox(width: 10),
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
