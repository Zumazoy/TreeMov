import 'package:flutter/material.dart';

import 'calendar_day_cell.dart';

class CalendarGrid extends StatelessWidget {
  final DateTime currentDate;
  final int selectedDay;
  final Set<int> daysWithLessons;
  final Function(int) onDaySelected;

  const CalendarGrid({
    super.key,
    required this.currentDate,
    required this.selectedDay,
    required this.daysWithLessons,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(currentDate.year, currentDate.month, 1);
    final startingWeekday = firstDay.weekday;

    final daysInMonth = DateTime(
      currentDate.year,
      currentDate.month + 1,
      0,
    ).day;

    List<Widget> dayWidgets = [];

    for (int i = 1; i < startingWeekday; i++) {
      dayWidgets.add(const SizedBox.shrink());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final hasLesson = daysWithLessons.contains(day);
      final isSelected = day == selectedDay;
      final isToday =
          day == DateTime.now().day &&
          currentDate.month == DateTime.now().month &&
          currentDate.year == DateTime.now().year;

      dayWidgets.add(
        GestureDetector(
          onTap: () => onDaySelected(day),
          child: CalendarDayCell(
            day: day,
            isSelected: isSelected,
            isToday: isToday,
            hasLesson: hasLesson,
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      childAspectRatio: 1,
      mainAxisSpacing: 0.1,
      crossAxisSpacing: 1,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: dayWidgets,
    );
  }
}
