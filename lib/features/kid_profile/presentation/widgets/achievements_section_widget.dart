// import 'package:flutter/material.dart';
// import 'package:treemov/core/themes/app_colors.dart';
// import 'package:treemov/features/kid_profile/presentation/all_achievements_screen.dart';
// import 'package:treemov/features/kid_profile/test/test_data.dart';

// import '../../domain/student_profile_models.dart';
// import 'achievement_chip_widget.dart';

// class AchievementsSectionWidget extends StatelessWidget {
//   final List<AchievementChipData> achievements;
//   final List<String> obtainedAchievements;
//   final Map<String, double> achievementProgress;
//   final Map<String, int> achievementCurrent;
//   final Map<String, int> achievementTotal;

//   const AchievementsSectionWidget({
//     super.key,
//     required this.achievements,
//     required this.obtainedAchievements,
//     required this.achievementProgress,
//     required this.achievementCurrent,
//     required this.achievementTotal,
//   });

//   Color _getChipColor(String label) {
//     switch (label) {
//       case 'Первый шаг':
//         return AppColors.entranceKidButton;
//       case 'Инноватор':
//         return AppColors.achievementGold;
//       case 'Герой':
//         return AppColors.achievementDeepBlue;
//       case 'Гений':
//         return AppColors.achievementGreen;
//       case 'Квестер':
//         return AppColors.achievementOrange;
//       case 'Lvl up':
//         return AppColors.achievementOrange;
//       case 'Полное погружение':
//         return AppColors.achievementDarkBlue;
//       case 'Мастер энергий':
//         return AppColors.achievementDeepBlue;
//       case 'Командный игрок':
//         return AppColors.achievementYellow;
//       case 'Защитник дерева':
//         return AppColors.achievementForestGreen;
//       default:
//         return AppColors.entranceKidButton;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (achievements.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Image.asset(
//                 'assets/images/medal_icon.png',
//                 width: 20,
//                 height: 20,
//                 color: AppColors.kidButton,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 'Последние достижения',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w900,
//                   fontFamily: 'TT Norms',
//                   color: AppColors.kidButton,
//                   height: 1.0,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           SizedBox(
//             height: 36,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: achievements.length,
//               separatorBuilder: (context, index) => const SizedBox(width: 8),
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AllAchievementsScreen(
//                           achievements: KidProfileTestData.achievements,
//                           obtainedAchievements: obtainedAchievements,
//                           achievementDescriptions:
//                               KidProfileTestData.achievementDescriptions,
//                           achievementDates: KidProfileTestData.achievementDates,
//                           achievementProgress: achievementProgress,
//                           achievementCurrent: achievementCurrent,
//                           achievementTotal: achievementTotal,
//                         ),
//                       ),
//                     );
//                   },
//                   child: AchievementChipWidget(
//                     label: achievements[index].label,
//                     iconPath: achievements[index].iconPath,
//                     backgroundColor: _getChipColor(achievements[index].label),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
