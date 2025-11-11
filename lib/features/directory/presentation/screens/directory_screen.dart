import 'package:flutter/material.dart';
import 'package:treemov/features/directory/data/mocks/mock_directory_data.dart';
import 'package:treemov/features/directory/domain/entities/group_entity.dart';
import 'package:treemov/features/directory/domain/entities/subject_entity.dart';
import 'package:treemov/features/directory/presentation/screens/student_directory.dart';
import 'package:treemov/features/directory/presentation/widgets/app_bar_title.dart';
import 'package:treemov/features/directory/presentation/widgets/group_item.dart';
import 'package:treemov/features/directory/presentation/widgets/search_field.dart';

import '../../../../../core/themes/app_colors.dart';

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({super.key});

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<GroupEntity> _filteredGroups = MockDirectoryData.groups;

  SubjectEntity _getSubjectById(String subjectId) {
    switch (subjectId) {
      case '1':
        return MockDirectoryData.physics;
      case '2':
        return MockDirectoryData.math;
      default:
        return MockDirectoryData.physics;
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredGroups = MockDirectoryData.groups;
      } else {
        _filteredGroups = MockDirectoryData.groups.where((group) {
          final subject = _getSubjectById(group.subjectId);
          return subject.name.toLowerCase().contains(query.toLowerCase()) ||
              group.name.contains(query);
        }).toList();
      }
    });
  }

  void _onGroupTap(GroupEntity group) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDirectoryScreen(
          groupName: group.name,
          subjectName: _getSubjectById(group.subjectId).name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const AppBarTitle(text: 'Ученики'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.grayFieldText,
        elevation: 0,
      ),
      body: Column(
        children: [
          SearchField(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ..._filteredGroups.map(
                  (group) => GroupItem(
                    group: group,
                    subject: _getSubjectById(group.subjectId),
                    onTap: () => _onGroupTap(group),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
