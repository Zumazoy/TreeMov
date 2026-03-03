import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

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
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'TT Norms',
                  color: AppColors.kidButton,
                  height: 1.0,
                ),
              ),
              Text(
                '$currentExp/$nextLevelExp',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'TT Norms',
                  color: AppColors.statsPinnedText,
                  height: 1.0,
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
