import 'package:flutter/material.dart';
import '../../domain/entities/note_category_entity.dart';
import '../../../../core/themes/app_colors.dart';
import 'filter_categories_section.dart';
import '../../domain/entities/teacher_note_entity.dart';
import 'filter_period_section.dart';
import 'filter_quick_section.dart';

class FilterModal extends StatefulWidget {
  final List<NoteCategoryEntity> initialSelectedCategories;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final String? initialQuickFilter;
  final List<TeacherNoteEntity> allNotes;
  final Function(
    List<NoteCategoryEntity> selectedCategories,
    DateTime? startDate,
    DateTime? endDate,
    String? quickFilter,
  )
  onApplyFilters;

  const FilterModal({
    super.key,
    required this.initialSelectedCategories,
    required this.initialStartDate,
    required this.initialEndDate,
    required this.initialQuickFilter,
    required this.allNotes,
    required this.onApplyFilters,
  });

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  late List<NoteCategoryEntity> _selectedCategories;
  late DateTime? _startDate;
  late DateTime? _endDate;
  late String? _quickFilter;

  @override
  void initState() {
    super.initState();
    _selectedCategories = List.from(widget.initialSelectedCategories);
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
    _quickFilter = widget.initialQuickFilter;
  }

  int get _activeFiltersCount {
    int count = _selectedCategories.length;
    if (_startDate != null || _endDate != null) count++;
    if (_quickFilter != null) count++;
    return count;
  }

  void _clearAllFilters() {
    setState(() {
      _selectedCategories.clear();
      _startDate = null;
      _endDate = null;
      _quickFilter = null;
    });
  }

  void _applyFilters() {
    widget.onApplyFilters(
      _selectedCategories,
      _startDate,
      _endDate,
      _quickFilter,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 367,
      constraints: const BoxConstraints(minHeight: 400),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Фильтр заметок',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              height: 1.0,
              color: AppColors.notesDarkText,
            ),
          ),

          const SizedBox(height: 20),

          FilterCategoriesSection(
            selectedCategories: _selectedCategories,
            onCategoryToggled: (category) {
              setState(() {
                if (_selectedCategories.contains(category)) {
                  _selectedCategories.remove(category);
                } else {
                  _selectedCategories.add(category);
                }
              });
            },
            allNotes: widget.allNotes,
          ),

          const SizedBox(height: 20),

          FilterPeriodSection(
            startDate: _startDate,
            endDate: _endDate,
            onStartDateChanged: (date) => setState(() => _startDate = date),
            onEndDateChanged: (date) => setState(() => _endDate = date),
          ),

          const SizedBox(height: 20),

          FilterQuickSection(
            selectedFilter: _quickFilter,
            onFilterToggled: (filter) {
              setState(() {
                _quickFilter = _quickFilter == filter ? null : filter;
              });
            },
            allNotes: widget.allNotes,
          ),

          const SizedBox(height: 20),

          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: 32,
            child: ElevatedButton(
              onPressed: _clearAllFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.teacherPrimary,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: AppColors.teacherPrimary, width: 1),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Очистить',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 1.0,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: SizedBox(
            height: 32,
            child: ElevatedButton(
              onPressed: _applyFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.teacherPrimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                'Применить ($_activeFiltersCount)',
                style: const TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
