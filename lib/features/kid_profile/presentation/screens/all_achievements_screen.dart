import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

import '../../domain/student_profile_models.dart';

Color _getAchievementColor(String label) {
  switch (label) {
    case 'Первый шаг':
      return AppColors.entranceKidButton;
    case 'Инноватор':
      return AppColors.achievementGold;
    case 'Герой':
      return AppColors.achievementDeepBlue;
    case 'Гений':
      return AppColors.achievementGreen;
    case 'Квестер':
      return AppColors.achievementOrange;
    case 'Lvl up':
      return AppColors.achievementOrange;
    case 'Полное погружение':
      return AppColors.achievementDarkBlue;
    case 'Мастер энергий':
      return AppColors.achievementDeepBlue;
    case 'Командный игрок':
      return AppColors.achievementYellow;
    case 'Защитник дерева':
      return AppColors.achievementForestGreen;
    default:
      return AppColors.entranceKidButton;
  }
}

class AllAchievementsScreen extends StatelessWidget {
  final List<AchievementChipData> achievements;
  final List<String> obtainedAchievements;
  final Map<String, String> achievementDescriptions;
  final Map<String, String> achievementDates;
  final Map<String, double> achievementProgress;
  final Map<String, int> achievementCurrent;
  final Map<String, int> achievementTotal;

  const AllAchievementsScreen({
    super.key,
    required this.achievements,
    required this.obtainedAchievements,
    required this.achievementDescriptions,
    required this.achievementDates,
    required this.achievementProgress,
    required this.achievementCurrent,
    required this.achievementTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kidPrimary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/achievement_icon.png',
                    width: 32,
                    height: 32,
                    color: AppColors.white,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Мои достижения',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'TT Norms',
                      color: AppColors.white,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  final achievement = achievements[index];
                  final isObtained = obtainedAchievements.contains(
                    achievement.label,
                  );
                  final circleColor = _getAchievementColor(achievement.label);
                  final progress =
                      achievementProgress[achievement.label] ?? 0.0;
                  final current = achievementCurrent[achievement.label] ?? 0;
                  final total = achievementTotal[achievement.label] ?? 100;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.entranceKidButton,
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                  color: isObtained
                                      ? circleColor
                                      : AppColors.grey.withAlpha(0x40),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Center(
                                  child: isObtained
                                      ? Image.asset(
                                          achievement.iconPath,
                                          width: 50,
                                          height: 50,
                                          color: AppColors.white,
                                        )
                                      : Image.asset(
                                          'assets/images/lock_icon.png',
                                          width: 40,
                                          height: 40,
                                          color: AppColors.white.withAlpha(
                                            0x80,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(width: 13),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      achievement.label,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'TT Norms',
                                        color: AppColors.white,
                                        height: 1.0,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      achievementDescriptions[achievement
                                              .label] ??
                                          '',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'TT Norms',
                                        color: AppColors.white,
                                        height: 1.0,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          if (!isObtained) ...[
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Прогресс',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'TT Norms',
                                            color: AppColors.white,
                                            height: 1.0,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '$current/$total',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'TT Norms',
                                            color: AppColors.white,
                                            height: 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Stack(
                                      children: [
                                        Container(
                                          width: 150,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: AppColors.white.withAlpha(
                                              0x32,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 150 * progress,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: AppColors.kidPrimary,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],

                          if (isObtained) ...[
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                Text(
                                  achievementDates[achievement.label] ?? '—',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'TT Norms',
                                    color: AppColors.white,
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
