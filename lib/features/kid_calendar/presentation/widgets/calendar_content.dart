import 'package:flutter/material.dart';

import 'calendar_grid.dart';
import 'month_header.dart';

class CalendarContent extends StatelessWidget {
  final DateTime currentDate;
  final int selectedDay;
  final Set<int> daysWithLessons;
  final Function(int) onMonthChanged;
  final Function(int) onDaySelected;

  const CalendarContent({
    super.key,
    required this.currentDate,
    required this.selectedDay,
    required this.daysWithLessons,
    required this.onMonthChanged,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform.translate(
          offset: const Offset(0, -10),
          child: MonthHeader(
            currentDate: currentDate,
            onMonthChanged: onMonthChanged,
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CalendarGrid(
                      currentDate: currentDate,
                      selectedDay: selectedDay,
                      daysWithLessons: daysWithLessons,
                      onDaySelected: onDaySelected,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
