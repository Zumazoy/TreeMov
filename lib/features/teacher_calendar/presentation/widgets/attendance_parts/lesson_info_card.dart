import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class LessonInfoCard extends StatelessWidget {
  final Map<String, dynamic> lesson;
  final double availableWidth;

  const LessonInfoCard({
    super.key,
    required this.lesson,
    required this.availableWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: availableWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.eventTap,
        borderRadius: BorderRadius.circular(12.5),
        border: Border.all(color: AppColors.calendarButton, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ВИД ЗАНЯТИЯ
          Text(
            lesson['type'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'TT Norms',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          // Данные о занятии
          SizedBox(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Левая колонка
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        icon: 'assets/images/activity_icon.png',
                        text: lesson['title'],
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        icon: 'assets/images/clock_icon.png',
                        text: lesson['time'],
                      ),
                    ],
                  ),
                ),

                // Правая колонка
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        icon: 'assets/images/place_icon.png',
                        text: lesson['location'],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String icon, required String text}) {
    return Row(
      children: [
        Image.asset(
          icon,
          width: 16,
          height: 16,
          color: AppColors.grayFieldText,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'TT Norms',
            color: AppColors.grayFieldText,
          ),
        ),
      ],
    );
  }
}
