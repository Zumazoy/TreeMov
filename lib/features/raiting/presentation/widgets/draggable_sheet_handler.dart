import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class DraggableSheetHandler extends StatelessWidget {
  const DraggableSheetHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 14, bottom: 4),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.achievementDeepBlue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}
