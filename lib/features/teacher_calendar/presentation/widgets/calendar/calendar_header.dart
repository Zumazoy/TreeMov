import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);

    return Container(
      width: 327,
      height: 48,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: theme.colorScheme.onPrimary,
              size: 24,
            ),
            onPressed: onPrevMonth,
          ),
          Center(
            child: Text(
              CalendarUtils.getMonthYearText(currentDate),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onPrimary,
                fontFamily: 'Arial',
                height: 1.0,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onPrimary,
              size: 24,
            ),
            onPressed: onNextMonth,
          ),
        ],
      ),
    );
  }
}
