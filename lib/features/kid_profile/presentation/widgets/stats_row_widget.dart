import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class StatsRowWidget extends StatelessWidget {
  final int totalEarnings;
  final int attendance;
  final int achievementsCount;

  const StatsRowWidget({
    super.key,
    required this.totalEarnings,
    required this.attendance,
    required this.achievementsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              iconPath: 'assets/images/rising_arrow.png',
              value: totalEarnings.toString(),
              label: 'всего заработано',
              valueColor: AppColors.statsTotalText,
              iconColor: AppColors.statsTotalText,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatCard(
              iconPath: 'assets/images/target_icon.png',
              value: '$attendance%',
              label: 'посещаемость',
              valueColor: AppColors.statsPinnedText,
              iconColor: AppColors.statsPinnedText,
            ),
          ),
          const SizedBox(width: 8),

          Expanded(
            child: _buildStatCard(
              iconPath: 'assets/images/achievement_icon.png',
              value: achievementsCount.toString(),
              label: 'достижения',
              valueColor: AppColors.categoryGeneralText,
              iconColor: AppColors.categoryGeneralText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String iconPath,
    required String value,
    required String label,
    required Color valueColor,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            child: Image.asset(iconPath, width: 24, height: 24),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'TT Norms',
              color: valueColor,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w300,
              fontFamily: 'TT Norms',
              color: AppColors.kidButton,
              height: 1.0,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.visible,
            softWrap: false,
          ),
        ],
      ),
    );
  }
}
