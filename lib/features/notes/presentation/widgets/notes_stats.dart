import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class NotesStats extends StatelessWidget {
  final int totalNotes;
  final int pinnedCount;
  final int todayCount;

  const NotesStats({
    super.key,
    required this.totalNotes,
    required this.pinnedCount,
    required this.todayCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        children: [
          Expanded(
            child: _buildStatContainer(
              count: totalNotes,
              title: 'Всего заметок',
              bgColor: AppColors.statsTotalBg,
              borderColor: AppColors.statsTotalBorder,
              countColor: AppColors.statsTotalText,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatContainer(
              count: pinnedCount,
              title: 'Закрепленных',
              bgColor: AppColors.statsPinnedBg,
              borderColor: AppColors.statsPinnedBorder,
              countColor: AppColors.statsPinnedText,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatContainer(
              count: todayCount,
              title: 'Сегодня',
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