import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/reports/data/mocks/mock_reports_data.dart';
import 'package:treemov/features/reports/domain/entities/report_entity.dart';
import 'package:treemov/features/reports/presentation/widgets/report_creation_modal.dart';
// import 'package:treemov/features/reports/presentation/widgets/filter_categories_section.dart';
// import 'package:treemov/features/reports/presentation/widgets/filter_quick_section.dart';
import 'package:treemov/features/reports/presentation/widgets/report_filter_modal.dart';
import 'package:treemov/features/reports/presentation/widgets/report_item.dart';
import 'package:treemov/features/reports/presentation/widgets/reports_stats.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final List<ReportEntity> _reports = MockReportsData.mockReports;
  String _selectedFilter = 'Все отчеты';

  // Состояния для хранения активных фильтров (оставлены закомментированными)
  // ReportFilterCategory? _activeCategoryFilter;
  // ReportQuickFilter? _activeQuickFilter;
  // DateTime? _activeStartDate;
  // DateTime? _activeEndDate;

  int get _readyReportsCount =>
      _reports.where((r) => r.status == ReportStatus.ready).length;
  int get _thisWeekCount => 3;
  int get _thisMonthCount => 32;

  @override
  void dispose() {
    super.dispose();
  }

  List<ReportEntity> get _filteredReports {
    List<ReportEntity> filtered = _reports.where((report) {
      final matchesFilter =
          _selectedFilter == 'Все отчеты' ||
          (_selectedFilter == 'Успеваемость' &&
              report.title.contains('Успеваемость')) ||
          (_selectedFilter == 'Посещаемость' &&
              report.title.contains('Посещаемость')) ||
          (_selectedFilter == 'Рейтинг' && report.title.contains('Рейтинг'));

      return matchesFilter;
    }).toList();

    return filtered;
  }

  void _onFilterSelected(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _onDownloadReport(ReportEntity report) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Начат процесс скачивания отчета: ${report.title}'),
        backgroundColor: AppColors.teacherPrimary,
      ),
    );
  }

  void _showFilterModal() {
    ReportFilterModal.show(
      context: context,
      onApplyFilters: (category, quickFilter, startDate, endDate) {
        setState(() {
          // _activeCategoryFilter = category;
          // _activeQuickFilter = quickFilter;
          // _activeStartDate = startDate;
          // _activeEndDate = endDate;
        });
      },
    );
  }

  Widget _buildCreateReportSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.directoryBorder, width: 1),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.description_outlined,
              size: 40,
              color: AppColors.directoryTextSecondary,
            ),
            const SizedBox(height: 12),
            const Text(
              'Создать новый отчет',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.grayFieldText,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Выберите отчет и период для генерации',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.directoryTextSecondary,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  ReportCreationModal.show(
                    context: context,
                    onReportCreated: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Запрос на создание отчета отправлен!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      // Здесь можно добавить логику для немедленного обновления списка
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.teacherPrimary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Создать отчет'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    final List<String> categories = [
      'Все отчеты',
      'Успеваемость',
      'Посещаемость',
      'Рейтинг',
    ];

    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: categories.map((category) {
          final isSelected = _selectedFilter == category;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(
                category,
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
              onSelected: (selected) => _onFilterSelected(category),
              selectedColor: AppColors.teacherPrimary,
              backgroundColor: AppColors.eventTap,
              checkmarkColor: AppColors.white,
              side: BorderSide(
                color: isSelected
                    ? AppColors.teacherPrimary
                    : AppColors.eventTap,
                width: 1,
              ),
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

  Widget _buildFilterButton() {
    return TextButton.icon(
      onPressed: _showFilterModal,
      icon: const Icon(
        Icons.filter_list,
        size: 20,
        color: AppColors.grayFieldText,
      ),
      label: const Text(
        'Фильтр',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.grayFieldText,
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredReports = _filteredReports;

    return Scaffold(
      backgroundColor: AppColors.notesBackground,
      appBar: AppBar(
        backgroundColor: AppColors.notesBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: const Row(
          children: [
            Icon(
              Icons.description_outlined,
              color: AppColors.notesDarkText,
              size: 28,
            ),
            SizedBox(width: 8),
            Text(
              'Отчеты',
              style: TextStyle(
                fontFamily: 'TT Norms',
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: AppColors.notesDarkText,
              ),
            ),
          ],
        ),
        actions: const [SizedBox.shrink()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryFilters(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ReportsStats(
              totalReports: _readyReportsCount,
              thisWeekCount: _thisWeekCount,
              thisMonthCount: _thisMonthCount,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Все отчеты',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                _buildFilterButton(),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                ...filteredReports.map((report) {
                  return ReportItem(
                    report: report,
                    onDownload: report.status == ReportStatus.ready
                        ? () => _onDownloadReport(report)
                        : null,
                  );
                }),

                _buildCreateReportSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
