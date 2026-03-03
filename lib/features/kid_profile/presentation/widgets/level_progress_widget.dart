import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class LevelProgressWidget extends StatelessWidget {
  final int currentExp;
  final int nextLevelExp;
  final double height;
  final double width;

  const LevelProgressWidget({
    super.key,
    required this.currentExp,
    required this.nextLevelExp,
    this.height = 12,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (currentExp / nextLevelExp).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Прогресс до следующего уровня',
                style: AppTextStyles.ttNorms10W400.copyWith(
                  color: AppColors.kidButton,
                ),
              ),
              Text(
                '$currentExp/$nextLevelExp',
                style: AppTextStyles.ttNorms14W900.copyWith(
                  color: AppColors.statsPinnedText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          LayoutBuilder(
            builder: (context, constraints) {
              final double availableWidth = constraints.maxWidth;

              return Stack(
                children: [
                  Container(
                    width: availableWidth,
                    height: height,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(height / 2),
                    ),
                  ),
                  if (progress > 0)
                    Container(
                      width: availableWidth * progress,
                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height / 2),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF19BCDB), Color(0xFF741CDB)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
