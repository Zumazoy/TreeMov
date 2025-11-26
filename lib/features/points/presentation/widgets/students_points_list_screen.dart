import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../directory/presentation/widgets/search_field.dart';
import '../../data/mocks/mock_points_data.dart';
import '../widgets/student_avatar.dart';
import '../widgets/action_selection_dialog.dart';
import '../../domain/entities/point_category_entity.dart';
import '../widgets/points_snackbar.dart';

class StudentsPointsListScreen extends StatefulWidget {
  final dynamic group;

  const StudentsPointsListScreen({super.key, required this.group});

  @override
  State<StudentsPointsListScreen> createState() =>
      _StudentsPointsListScreenState();
}

class _StudentsPointsListScreenState extends State<StudentsPointsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<StudentWithPoints> _filteredStudents =
      MockPointsData.mockStudentsWithPoints;

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredStudents = MockPointsData.mockStudentsWithPoints;
      } else {
        _filteredStudents = MockPointsData.mockStudentsWithPoints.where((
          student,
        ) {
          return student.fullName.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _onAddPointsPressed(StudentWithPoints student) {
    _showActionSelectionDialog(student);
  }

  void _showActionSelectionDialog(StudentWithPoints student) {
    showDialog(
      context: context,
      builder: (context) => ActionSelectionDialog(student: student),
    ).then((selectedAction) {
      if (selectedAction != null) {
        _showConfirmationScreen(student, selectedAction);
      }
    });
  }

  void _showConfirmationScreen(StudentWithPoints student, PointAction action) {
    PointsSnackBar.show(context: context, student: student, action: action);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Группа ${widget.group.name}',
          style: const TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.notesDarkText,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SearchField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            hintText: 'Найти ученика...',
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredStudents.length,
              itemBuilder: (context, index) {
                final student = _filteredStudents[index];
                return _buildStudentCard(student);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentCard(StudentWithPoints student) {
    final attendancePercent = (student.attendancePercentage * 100).toInt();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.directoryBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          StudentAvatar(avatarUrl: student.avatarUrl),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.fullName,
                  style: const TextStyle(
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.notesDarkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'посещаемость: $attendancePercent%',
                  style: const TextStyle(
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    height: 1.0,
                    color: AppColors.directoryTextSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${student.totalPoints} баллов',
                  style: const TextStyle(
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    height: 1.0,
                    color: AppColors.directoryTextSecondary,
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.teacherPrimary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton.icon(
              onPressed: () => _onAddPointsPressed(student),
              icon: const Icon(Icons.add, color: AppColors.white, size: 16),
              label: const Text(
                'Начислить',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 12,
                  color: AppColors.white,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
