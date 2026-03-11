import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_text_styles.dart';
import 'package:treemov/features/reports/presentation/screens/reports_screen.dart';

class RepNotsButtons extends StatelessWidget {
  const RepNotsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.primary),
              borderRadius: BorderRadius.circular(8),
              color: theme.cardColor,
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
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Отчеты',
                    style: AppTextStyles.arial14W400.copyWith(
                      color: theme.colorScheme.primary,
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
              border: Border.all(color: theme.colorScheme.primary),
              borderRadius: BorderRadius.circular(8),
              color: theme.cardColor, // 👈 ИСПРАВЛЕНО
            ),
            child: TextButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const NotesScreen()),
                // );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/text_icon.png',
                    width: 24,
                    height: 24,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Заметки',
                    style: AppTextStyles.arial14W400.copyWith(
                      color: theme.colorScheme.primary,
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
