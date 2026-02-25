import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

import '../../domain/student_profile_models.dart';
import 'activity_item_widget.dart';

class ActivitySectionWidget extends StatelessWidget {
  final List<ActivityItemData> activities;
  final bool isLoading;
  final VoidCallback? onLoadMore;

  const ActivitySectionWidget({
    super.key,
    required this.activities,
    this.isLoading = false,
    this.onLoadMore,
  });

  Color _getCircleColor(String title) {
    if (title.contains('Пассивность') || title.contains('Мешал')) {
      return AppColors.activityRedWithOpacity;
    } else if (title.contains('Присутствие')) {
      return AppColors.activityBlueWithOpacity;
    } else if (title.contains('конкурсе') ||
        title.contains('Отличный проект')) {
      return AppColors.activityCream;
    } else if (title.contains('домашнего')) {
      return AppColors.activityPurpleWithOpacity;
    }
    return Colors.grey.withAlpha(0x26);
  }

  Color _getIconColor(String title) {
    if (title.contains('Пассивность') || title.contains('Мешал')) {
      return AppColors.activityRed;
    } else if (title.contains('Присутствие')) {
      return AppColors.activityBlue;
    } else if (title.contains('конкурсе') ||
        title.contains('Отличный проект')) {
      return AppColors.achievementGold;
    } else if (title.contains('домашнего')) {
      return AppColors.activityPurple;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/clock_icon.png',
                width: 20,
                height: 20,
                color: AppColors.kidButton,
              ),
              const SizedBox(width: 8),
              Text(
                'Последняя активность',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'TT Norms',
                  color: AppColors.notesDarkText,
                  height: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length + (isLoading ? 1 : 0),
            separatorBuilder: (context, index) => const SizedBox(height: 0),
            itemBuilder: (context, index) {
              if (index == activities.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final activity = activities[index];
              return ActivityItemWidget(
                title: activity.title,
                date: activity.date,
                time: activity.time,
                points: activity.points,
                iconPath: activity.iconPath,
                circleColor: _getCircleColor(activity.title),
                iconColor: _getIconColor(activity.title),
              );
            },
          ),
        ],
      ),
    );
  }
}
