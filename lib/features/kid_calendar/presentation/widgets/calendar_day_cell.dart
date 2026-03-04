import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class CalendarDayCell extends StatelessWidget {
  final int day;
  final bool isSelected;
  final bool isToday;
  final bool hasLesson;

  const CalendarDayCell({
    super.key,
    required this.day,
    required this.isSelected,
    required this.isToday,
    required this.hasLesson,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.kidCalendarBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isToday
            ? Border.all(color: AppColors.kidButton, width: 2)
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 0,
        children: [
          const SizedBox(height: 8),
          Text(
            day.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'TT Norms',
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 8,
            child: hasLesson
                ? Transform.translate(
                    offset: const Offset(0, -2),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white
                              : AppColors.kidButton,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
