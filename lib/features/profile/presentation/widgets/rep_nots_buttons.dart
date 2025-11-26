import 'package:flutter/material.dart';
import 'package:treemov/features/reports/presentation/screens/reports_screen.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../notes/presentation/screens/notes_screen.dart';

class RepNotsButtons extends StatelessWidget {
  const RepNotsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.teacherPrimary),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.eventTap,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportsScreen(),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/paper_icon.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Отчеты',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.normal,
                      color: AppColors.teacherPrimary,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.teacherPrimary),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.eventTap,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotesScreen()),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/text_icon.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Заметки',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.normal,
                      color: AppColors.teacherPrimary,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
