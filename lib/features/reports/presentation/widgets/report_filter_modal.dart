import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

import 'filter_categories_section.dart';
import 'filter_quick_section.dart';

class ReportFilterModal extends StatefulWidget {
  final ReportFilterCategory? initialSelectedCategory;
  final ReportQuickFilter? initialQuickFilter;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;

  final Function(
    ReportFilterCategory? selectedCategory,
    ReportQuickFilter? quickFilter,
    DateTime? startDate,
    DateTime? endDate,
  )
  onApplyFilters;

  const ReportFilterModal({
    super.key,
    this.initialSelectedCategory,
    this.initialQuickFilter,
    this.initialStartDate,
    this.initialEndDate,
    required this.onApplyFilters,
  });

  static Future<void> show({
    required BuildContext context,
    required Function(
      ReportFilterCategory?,
      ReportQuickFilter?,
      DateTime?,
      DateTime?,
    )
    onApplyFilters,
  }) {
    // В реальном приложении здесь передаются текущие активные фильтры
    return showDialog(
      context: context,
      builder: (context) => ReportFilterModal(onApplyFilters: onApplyFilters),
    );
  }

  @override
  State<ReportFilterModal> createState() => _ReportFilterModalState();
}

class _ReportFilterModalState extends State<ReportFilterModal> {
  ReportFilterCategory? _selectedCategory;
  ReportQuickFilter? _quickFilter;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialSelectedCategory;
    _quickFilter = widget.initialQuickFilter;
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
  }

  int get _activeFiltersCount {
    int count = 0;
    if (_selectedCategory != null) count++;
    if (_quickFilter != null) count++;
    if (_startDate != null || _endDate != null) count++;
    return count;
  }

  void _clearAllFilters() {
    setState(() {
      _selectedCategory = null;
      _quickFilter = null;
      _startDate = null;
      _endDate = null;
    });
  }

  void _applyFilters() {
    widget.onApplyFilters(
      _selectedCategory,
      _quickFilter,
      _startDate,
      _endDate,
    );
    Navigator.pop(context);
  }

  Future<void> _selectDate(bool isStart) async {
    final initialDate = isStart ? _startDate : _endDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.teacherPrimary,
              onPrimary: AppColors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: 367,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),

            // 1. Категория
            ReportFilterCategoriesSection(
              selectedCategory: _selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  // Для радио-кнопок: если выбрана та же категория, сбрасываем ее (null)
                  _selectedCategory = _selectedCategory == category
                      ? null
                      : category;
                });
              },
            ),
            const SizedBox(height: 20),

            // 2. Период
            _buildPeriodSection(),
            const SizedBox(height: 20),

            // 3. Быстрый фильтр
            ReportFilterQuickSection(
              selectedFilter: _quickFilter,
              onFilterSelected: (filter) {
                setState(() {
                  _quickFilter = _quickFilter == filter ? null : filter;
                });
              },
            ),
            const SizedBox(height: 20),

            // 4. Кнопки действий
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Фильтр отчетов',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            height: 1.0,
            color: AppColors.notesDarkText,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.teacherPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildPeriodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Период:',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.0,
            color: AppColors.directoryTextSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildDateField('от', _startDate, (date) {
                setState(() => _startDate = date);
              }),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDateField('до', _endDate, (date) {
                setState(() => _endDate = date);
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateField(
    String label,
    DateTime? date,
    Function(DateTime?) onDateChanged,
  ) {
    return GestureDetector(
      onTap: () => _selectDate(label == 'от'),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.eventTap),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            Text(
              _formatDate(date),
              style: const TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.notesDarkText,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.calendar_today,
              size: 16,
              color: AppColors.grayFieldText,
            ),
          ],
        ),
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
            child: OutlinedButton(
              onPressed: _clearAllFilters,
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.teacherPrimary,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: AppColors.directoryBorder,
                    width: 1,
                  ),
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
