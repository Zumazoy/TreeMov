import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class GroupChips extends StatelessWidget {
  final List<String> groupIds;

  const GroupChips({super.key, required this.groupIds});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: groupIds.map((groupId) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.directoryBorder),
          ),
          child: Text(
            "Тест",
            style: const TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppColors.grayFieldText,
            ),
          ),
        );
      }).toList(),
    );
  }
}
