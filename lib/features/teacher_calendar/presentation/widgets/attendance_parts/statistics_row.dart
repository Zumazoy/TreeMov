import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class StatisticsRow extends StatelessWidget {
  final double availableWidth;
  final int totalStudents;
  final int presentCount;
  final int absentCount;
  final int notMarkedCount;

  const StatisticsRow({
    super.key,
    required this.availableWidth,
    required this.totalStudents,
    required this.presentCount,
    required this.absentCount,
    required this.notMarkedCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: availableWidth,
      height: 80,
      child: Row(
        children: [
          Expanded(
            child: _buildStatContainer(
              count: totalStudents,
              title: 'Всего',
              bgColor: AppColors.statsTodayBg,
              borderColor: AppColors.statsTodayBorder,
              countColor: AppColors.statsTodayText,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: _buildStatContainer(
              count: presentCount,
              title: 'Присутствует',
              bgColor: AppColors.statsTotalBg,
              borderColor: AppColors.statsTotalBorder,
              countColor: AppColors.statsTotalText,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: _buildStatContainer(
              count: absentCount,
              title: 'Отсутствует',
              bgColor: AppColors.statsAbsentBg,
              borderColor: AppColors.statsAbsentBorder,
              countColor: AppColors.statsAbsentText,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: _buildStatContainer(
              count: notMarkedCount,
              title: 'Не отмечено',
              bgColor: AppColors.notesBackground,
              borderColor: AppColors.statsNotMarkedBorder,
              countColor: AppColors.black,
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
            style: AppTextStyles.ttNorms20W700.copyWith(color: countColor),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.arial11W400.copyWith(color: countColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
