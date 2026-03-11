import 'package:flutter/material.dart';

class CalendarWeekDays extends StatelessWidget {
  const CalendarWeekDays({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const List<String> weekDays = ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ', 'ВС'];

    return SizedBox(
      width: 327,
      height: 40,
      child: Row(
        children: weekDays.map((day) {
          return Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              child: Text(
                day,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Arial',
                  color: theme.textTheme.bodyMedium?.color?.withAlpha(128),
                  height: 1.0,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
