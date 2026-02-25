import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

import '../../../core/widgets/layout/child_nav_bar.dart';
import '../domain/kid_profile_models.dart';
import 'widgets/achievements_section_widget.dart';
import 'widgets/activity_section_widget.dart';
import 'widgets/level_progress_widget.dart';
import 'widgets/profile_header_widget.dart';
import 'widgets/stats_row_widget.dart';

class KidProfileScreen extends StatelessWidget {
  final String name;
  final int level;
  final String levelTitle;
  final int currentExp;
  final int nextLevelExp;
  final int totalEarnings;
  final int attendance;
  final int achievementsCount;
  final int currentPoints;
  final List<AchievementChipData> achievements;
  final List<ActivityItemData> activities;
  final List<String> obtainedAchievements;
  final Map<String, double> achievementProgress;
  final Map<String, int> achievementCurrent;
  final Map<String, int> achievementTotal;

  const KidProfileScreen({
    super.key,
    required this.name,
    required this.level,
    required this.levelTitle,
    required this.currentExp,
    required this.nextLevelExp,
    required this.totalEarnings,
    required this.attendance,
    required this.achievementsCount,
    required this.currentPoints,
    required this.achievements,
    required this.activities,
    required this.obtainedAchievements,
    required this.achievementProgress,
    required this.achievementCurrent,
    required this.achievementTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kidPrimary, // Color(0xFFB6E4FB)
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF19BCDB), Color(0xFF741CDB)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds),
                        child: Image.asset(
                          'assets/images/energy_icon.png',
                          width: 24,
                          height: 24,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF19BCDB), Color(0xFF741CDB)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds),
                        child: Text(
                          'TreeMov',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.more_vert, color: AppColors.white),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFCEEFFF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            ProfileHeaderWidget(
                              name: name,
                              level: level,
                              levelTitle: levelTitle,
                              currentPoints: currentPoints,
                            ),
                            const SizedBox(height: 8),
                            LevelProgressWidget(
                              currentExp: currentExp,
                              nextLevelExp: nextLevelExp,
                            ),
                            const SizedBox(height: 16),
                            StatsRowWidget(
                              totalEarnings: totalEarnings,
                              attendance: attendance,
                              achievementsCount: achievementsCount,
                            ),
                            AchievementsSectionWidget(
                              achievements: achievements,
                              obtainedAchievements: obtainedAchievements,
                              achievementProgress: achievementProgress,
                              achievementCurrent: achievementCurrent,
                              achievementTotal: achievementTotal,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ActivitySectionWidget(activities: activities),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ChildBottomNavigationBar(
        currentIndex: 3,
        onTap: (index) => debugPrint('Нажата вкладка $index'),
      ),
    );
  }
}
