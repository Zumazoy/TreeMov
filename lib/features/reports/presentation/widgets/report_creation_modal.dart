import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

import 'report_selection_card.dart';

// Enum для типов отчетов (для первого шага)
enum ReportType {
  performance, // Успеваемость
  attendance, // Посещаемость
  rating, // Рейтинг по баллам
}

// Enum для выбора периода (для второго шага)
enum ReportPeriod {
  monthly, // За месяц
  quarterly, // За четверть
  custom, // Произвольный период
}

class ReportCreationModal extends StatefulWidget {
  final VoidCallback onReportCreated;

  const ReportCreationModal({super.key, required this.onReportCreated});

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onReportCreated,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        // Удаляем фиксированный отступ, чтобы модальное окно могло быть выше
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: ReportCreationModal(onReportCreated: onReportCreated),
      ),
    );
  }

  @override
  State<ReportCreationModal> createState() => _ReportCreationModalState();
}

class _ReportCreationModalState extends State<ReportCreationModal> {
  int _currentStep = 1;
  ReportType? _selectedReportType;
  ReportPeriod _selectedPeriod = ReportPeriod.monthly;
  bool _includeGraphs = true;
  bool _includeDetails = false;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  void _nextStep() {
    if (_currentStep == 1 && _selectedReportType != null) {
      setState(() => _currentStep = 2);
    }
  }

  void _backStep() {
    setState(() => _currentStep = 1);
  }

  void _createReport() {
    widget.onReportCreated();
    Navigator.of(context).pop();
  }

  Future<void> _selectDate(bool isStart) async {
    final initialDate = isStart ? _startDate : _endDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
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
          if (_startDate.isAfter(_endDate)) _endDate = _startDate;
        } else {
          _endDate = picked;
          if (_endDate.isBefore(_startDate)) _startDate = _endDate;
        }
      });
    }
  }

  String _formatDate(DateTime date) {
    // Формат даты, как в макете: "14-апреля-2025"
    final months = {
      1: 'января',
      2: 'февраля',
      3: 'марта',
      4: 'апреля',
      5: 'мая',
      6: 'июня',
      7: 'июля',
      8: 'августа',
      9: 'сентября',
      10: 'октября',
      11: 'ноября',
      12: 'декабря',
    };
    return '${date.day.toString().padLeft(2, '0')}-${months[date.month]}-${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    // Задаем максимальную высоту, чтобы контент помещался (до 90% экрана)
    final screenHeight = MediaQuery.of(context).size.height;
    final maxModalHeight = screenHeight * 0.9;

    return Container(
      padding: const EdgeInsets.all(20),
      constraints: BoxConstraints(maxHeight: maxModalHeight),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),

          // Flexible с SingleChildScrollView для предотвращения переполнения
          Flexible(
            child: SingleChildScrollView(
              child: _currentStep == 1 ? _buildStepOne() : _buildStepTwo(),
            ),
          ),

          _buildFooter(),
        ],
      ),
    );
  }

  // --- Виджеты построения шагов ---

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Создать отчет',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.notesDarkText,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.teacherPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildStepOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Выберите тип отчета:',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.directoryTextSecondary,
          ),
        ),
        const SizedBox(height: 12),
        ReportSelectionCard(
          icon: Icons.ssid_chart,
          title: 'Успеваемость',
          description: 'Отчёт по оценкам и успеваемости учеников',
          isSelected: _selectedReportType == ReportType.performance,
          onTap: () =>
              setState(() => _selectedReportType = ReportType.performance),
        ),
        ReportSelectionCard(
          icon: Icons.groups,
          title: 'Посещаемость',
          description: 'Статистика посещений и пропусков',
          isSelected: _selectedReportType == ReportType.attendance,
          onTap: () =>
              setState(() => _selectedReportType = ReportType.attendance),
        ),
        ReportSelectionCard(
          icon: Icons.bar_chart,
          title: 'Рейтинг по баллам',
          description: 'Система баллов и достижения учеников',
          isSelected: _selectedReportType == ReportType.rating,
          onTap: () => setState(() => _selectedReportType = ReportType.rating),
        ),
      ],
    );
  }

  Widget _buildStepTwo() {
    // В зависимости от выбранного типа отчета, меняем заголовок
    String reportTitle;
    String reportDescription;
    IconData reportIcon;

    switch (_selectedReportType) {
      case ReportType.performance:
        reportTitle = 'Успеваемость';
        reportDescription = 'Отчёт по оценкам и успеваемости учеников';
        reportIcon = Icons.ssid_chart;
        break;
      case ReportType.attendance:
        reportTitle = 'Посещаемость';
        reportDescription = 'Статистика посещений и пропусков';
        reportIcon = Icons.groups;
        break;
      case ReportType.rating:
        reportTitle = 'Рейтинг по баллам';
        reportDescription = 'Система баллов и достижения учеников';
        reportIcon = Icons.bar_chart;
        break;
      default:
        reportTitle = 'Выберите тип отчета';
        reportDescription = '';
        reportIcon = Icons.help_outline;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Отображаем выбранный тип отчета сверху
        ReportSelectionCard(
          icon: reportIcon,
          title: reportTitle,
          description: reportDescription,
          isSelected: true,
          onTap: () {},
        ),
        const SizedBox(height: 16),
        const Text(
          'Период:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.notesDarkText,
          ),
        ),
        const SizedBox(height: 8),

        // Выбор периода
        _buildPeriodOption(ReportPeriod.monthly, 'За месяц', 'Текущий месяц'),
        _buildPeriodOption(
          ReportPeriod.quarterly,
          'За четверть',
          'Текущая четверть',
        ),
        _buildPeriodOption(
          ReportPeriod.custom,
          'Произвольный период',
          'Выберите даты',
        ),
        const SizedBox(height: 20),

        // Выбор произвольного периода (если выбран)
        if (_selectedPeriod == ReportPeriod.custom)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: _buildDateInput(true, _startDate)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildDateInput(false, _endDate)),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),

        const Text(
          'Дополнительные параметры:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.notesDarkText,
          ),
        ),
        const SizedBox(height: 8),

        // Включить графики (чекбокс)
        _buildCheckboxOption(
          'Включить графики',
          'Диаграммы и визуализация данных',
          _includeGraphs,
          (value) => setState(() => _includeGraphs = value),
        ),
        // Детальная информация (чекбокс)
        _buildCheckboxOption(
          'Детальная информация',
          'Подробные данные по каждому ученику',
          _includeDetails,
          (value) => setState(() => _includeDetails = value),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildPeriodOption(
    ReportPeriod period,
    String title,
    String subtitle,
  ) {
    final isSelected = _selectedPeriod == period;
    return GestureDetector(
      onTap: () => setState(() => _selectedPeriod = period),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.eventTap : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.teacherPrimary : AppColors.eventTap,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.grayFieldText,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.directoryTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateInput(bool isStart, DateTime date) {
    return GestureDetector(
      onTap: () => _selectDate(isStart),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isStart ? 'Начальная дата' : 'Конечная дата',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.directoryTextSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.eventTap, width: 1),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                const Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: AppColors.grayFieldText,
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDate(date),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.grayFieldText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxOption(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: value ? AppColors.eventTap : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: value ? AppColors.teacherPrimary : AppColors.eventTap,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // Иконка (имитация радио/чекбокса)
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: value
                      ? AppColors.teacherPrimary
                      : AppColors.directoryTextSecondary,
                  width: value ? 6 : 2,
                ),
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.grayFieldText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.directoryTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    // Проверяем, можно ли перейти вперед (для Step 1)
    final isStepOneComplete = _currentStep == 1 && _selectedReportType != null;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _currentStep == 1
                  ? () => Navigator.of(context).pop()
                  : _backStep,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                side: const BorderSide(color: AppColors.teacherPrimary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                foregroundColor: AppColors.teacherPrimary,
              ),
              child: Text(_currentStep == 1 ? 'Отмена' : 'Назад'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _currentStep == 1
                  ? (isStepOneComplete ? _nextStep : null)
                  : _createReport,
              icon: Icon(
                _currentStep == 1 ? Icons.arrow_forward_ios : Icons.download,
                size: 18,
              ),
              label: Text(_currentStep == 1 ? 'Далее' : 'Создать отчет'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: AppColors.teacherPrimary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBackgroundColor: AppColors.eventTap,
                disabledForegroundColor: AppColors.directoryTextSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
