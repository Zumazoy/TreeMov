import 'package:flutter/material.dart';
import 'package:treemov/features/directory/data/mocks/mock_directory_data.dart';
import 'package:treemov/features/directory/domain/entities/group_entity.dart';

import '../../../../../core/themes/app_colors.dart';

class GroupChips extends StatelessWidget {
  final List<String> groupIds;

  const GroupChips({super.key, required this.groupIds});

  String _getGroupName(String groupId) {
    final group = MockDirectoryData.groups.firstWhere(
      (g) => g.id == groupId,
      orElse: () => GroupEntity(
        id: '',
        name: 'Неизвестно',
        subjectId: '',
        studentCount: 0,
      ),
    );
    return group.name;
  }

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
            _getGroupName(groupId),
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
