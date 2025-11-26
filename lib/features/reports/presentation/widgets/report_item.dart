import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

import '../../domain/entities/report_entity.dart';

class ReportItem extends StatelessWidget {
  final ReportEntity report;
  final VoidCallback? onDownload;

  const ReportItem({super.key, required this.report, this.onDownload});

  Color _getStatusBgColor(ReportStatus status) {
    switch (status) {
      case ReportStatus.ready:
        return AppColors.categoryStudyBg; // Зеленый для "Готов"
      case ReportStatus.generating:
        return AppColors.categoryGeneralBg; // Желтый для "Генерируется"
      case ReportStatus.error:
        return AppColors.categoryParentsBg; // Фиолетовый для "Ошибка"
    }
  }

  Color _getStatusTextColor(ReportStatus status) {
    switch (status) {
      case ReportStatus.ready:
        return AppColors.categoryStudyText;
      case ReportStatus.generating:
        return AppColors.categoryGeneralText;
      case ReportStatus.error:
        return AppColors.categoryParentsText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusBg = _getStatusBgColor(report.status);
    final statusText = _getStatusTextColor(report.status);
    final isReady = report.status == ReportStatus.ready;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.eventTap, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    report.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.grayFieldText,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    report.status.title,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: statusText,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Информация о периоде и обновлении
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: AppColors.directoryTextSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  report.period,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.directoryTextSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                if (report.size != '—' &&
                    report.status != ReportStatus.generating)
                  Text(
                    'Размер: ${report.size}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.directoryTextSecondary,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.watch_later_outlined,
                  size: 14,
                  color: AppColors.directoryTextSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Обновлён: ${report.updateTime}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.directoryTextSecondary,
                  ),
                ),
              ],
            ),

            if (isReady) ...[
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 100,
                  height: 36,
                  child: ElevatedButton.icon(
                    onPressed: onDownload,
                    icon: const Icon(Icons.download, size: 16),
                    label: const Text('Скачать'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teacherPrimary,
                      foregroundColor: AppColors.white,
                      textStyle: const TextStyle(fontSize: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ] else if (report.status == ReportStatus.generating)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.teacherPrimary,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Генерируется',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.teacherPrimary,
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
}
