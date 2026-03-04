import 'package:flutter/material.dart';

class CalendarAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CalendarAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 👈 ПОЛУЧАЕМ ТЕМУ

    return AppBar(
      backgroundColor: theme
          .appBarTheme
          .backgroundColor, // 👈 ИСПРАВЛЕНО (было AppColors.white)
      elevation: 0,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/calendar_simple_icon.png',
            width: 24,
            height: 24,
            color: theme.iconTheme.color, // 👈 ИСПРАВЛЕНО (было Colors.black)
          ),
          const SizedBox(width: 8),
          Text(
            'Календарь',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Arial',
              color: theme
                  .textTheme
                  .titleLarge
                  ?.color, // 👈 ИСПРАВЛЕНО (было Colors.black)
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
