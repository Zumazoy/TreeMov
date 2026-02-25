import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class ActivityItemWidget extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final int points;
  final String iconPath;
  final Color circleColor;
  final Color iconColor;

  const ActivityItemWidget({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.points,
    required this.iconPath,
    required this.circleColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = points > 0;
    final pointsText = isPositive ? '+$points' : points.toString();
    final pointsColor = isPositive ? AppColors.statsTotalText : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: circleColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 24,
                height: 24,
                color: iconColor,
              ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'TT Norms',
                    color: AppColors.kidButton,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$date в $time',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'TT Norms',
                    color: AppColors.kidButton,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),

          Text(
            pointsText,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              fontFamily: 'TT Norms',
              color: pointsColor,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
