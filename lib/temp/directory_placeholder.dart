import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class DirectoryPlaceholder extends StatelessWidget {
  const DirectoryPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Магазин',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.grayFieldText,
          ),
        ),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.grayFieldText,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.eventTap,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.construction,
                size: 60,
                color: AppColors.teacherPrimary,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Раздел в разработке',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.grayFieldText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
