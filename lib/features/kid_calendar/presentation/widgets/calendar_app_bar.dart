import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class CalendarAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CalendarAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/images/kid_calendar_icon.png',
            width: 24,
            height: 24,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.calendar_today,
                color: Colors.white,
                size: 24,
              );
            },
          ),
          const SizedBox(width: 8),
          const Text(
            'Календарь',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              fontFamily: 'TT Norms',
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.kidPrimary,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
