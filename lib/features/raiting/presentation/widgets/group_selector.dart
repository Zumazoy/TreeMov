import 'package:flutter/material.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';

class GroupSelector extends StatelessWidget {
  final List<GroupStudentsResponseModel> groups;
  final GroupStudentsResponseModel? selectedGroup;
  final Function(GroupStudentsResponseModel) onGroupSelected;

  const GroupSelector({
    super.key,
    required this.groups,
    required this.selectedGroup,
    required this.onGroupSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      height: 40, // Фиксированная высота для кнопки
      decoration: BoxDecoration(
        color: const Color(0xFF0099E9),
        borderRadius: BorderRadius.circular(30), // Более закругленные углы
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<GroupStudentsResponseModel>(
            value: selectedGroup,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            iconSize: 28,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            dropdownColor: const Color(0xFF0099E9),
            items: groups.map((group) {
              return DropdownMenuItem<GroupStudentsResponseModel>(
                value: group,
                child: Center(
                  child: Text(
                    group.title ?? 'Группа ${group.id}',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
            onChanged: (group) {
              if (group != null) {
                onGroupSelected(group);
              }
            },
          ),
        ),
      ),
    );
  }
}
