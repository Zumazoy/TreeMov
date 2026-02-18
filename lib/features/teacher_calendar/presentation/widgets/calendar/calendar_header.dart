import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../utils/calendar_utils.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime currentDate;
  final VoidCallback onNextMonth;
  final VoidCallback onPrevMonth;

  const CalendarHeader({
    super.key,
    required this.currentDate,
    required this.onNextMonth,
    required this.onPrevMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.calendarButton,
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: AppColors.white,
              size: 24,
            ),
            onPressed: onPrevMonth,
          ),
          Center(
            child: Text(
              CalendarUtils.getMonthYearText(currentDate),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                fontFamily: 'Arial',
                height: 1.0,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.chevron_right,
              color: AppColors.white,
              size: 24,
            ),
            onPressed: onNextMonth,
          ),
        ],
      ),
    );
  }
}
