import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class ReportsStats extends StatelessWidget {
  final int totalReports;
  final int thisWeekCount;
  final int thisMonthCount;

  const ReportsStats({
    super.key,
    required this.totalReports,
    required this.thisWeekCount,
    required this.thisMonthCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        children: [
          Expanded(
            child: _buildStatContainer(
              count: totalReports,
              title: 'Готовых отчетов',
              bgColor: AppColors.statsTotalBg,
              borderColor: AppColors.statsTotalBorder,
              countColor: AppColors.statsTotalText,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatContainer(
              count: thisWeekCount,
              title: 'За эту неделю',
              bgColor: AppColors.statsPinnedBg,
              borderColor: AppColors.statsPinnedBorder,
              countColor: AppColors.statsPinnedText,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatContainer(
              count: thisMonthCount,
              title: 'Всего за месяц',
              bgColor: AppColors.statsTodayBg,
              borderColor: AppColors.statsTodayBorder,
              countColor: AppColors.statsTodayText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatContainer({
    required int count,
    required String title,
    required Color bgColor,
    required Color borderColor,
    required Color countColor,
  }) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.5),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'TT Norms',
              color: countColor,
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                fontFamily: 'Arial',
                color: countColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
