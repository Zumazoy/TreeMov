import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class ActivityItemWidget extends StatelessWidget {
  final String title;
  final int points;
  final String iconPath;
  final Color circleColor;
  final Color iconColor;

  const ActivityItemWidget({
    super.key,
    required this.title,
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: circleColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 20,
                height: 20,
                color: iconColor,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.star, size: 20, color: iconColor);
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.ttNorms14W600.copyWith(
                color: AppColors.notesDarkText,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            pointsText,
            style: AppTextStyles.ttNorms18W700.copyWith(color: pointsColor),
          ),
        ],
      ),
    );
  }
}
