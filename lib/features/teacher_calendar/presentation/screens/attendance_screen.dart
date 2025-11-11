import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../widgets/attendance_parts/lesson_info_card.dart';
import '../widgets/attendance_parts/statistics_row.dart';
import '../widgets/attendance_parts/student_card.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // Данные о занятии
  final Map<String, dynamic> _currentLesson = {
    'title': 'Растяжка',
    'type': 'Группа "Слайд"',
    'time': '18:30-20:00',
    'location': 'Малый зал',
  };

  // Список студентов
  final List<Map<String, dynamic>> _students = [
    {'id': 1, 'name': 'Петров Иван', 'avatar': '', 'attendance': 'not_marked'},
    {
      'id': 2,
      'name': 'Сидорова Мария',
      'avatar': '',
      'attendance': 'not_marked',
    },
    {
      'id': 3,
      'name': 'Козлов Алексей',
      'avatar': '',
      'attendance': 'not_marked',
    },
  ];

  // Статистика
  int get totalStudents => _students.length;
  int get presentCount =>
      _students.where((s) => s['attendance'] == 'present').length;
  int get absentCount =>
      _students.where((s) => s['attendance'] == 'absent').length;
  int get notMarkedCount =>
      _students.where((s) => s['attendance'] == 'not_marked').length;

  void _markAllPresent() {
    setState(() {
      for (var student in _students) {
        student['attendance'] = 'present';
      }
    });
  }

  void _markPresent(int studentId) {
    setState(() {
      final student = _students.firstWhere((s) => s['id'] == studentId);
      student['attendance'] = 'present';
    });
  }

  void _markAbsent(int studentId) {
    setState(() {
      final student = _students.firstWhere((s) => s['id'] == studentId);
      student['attendance'] = 'absent';
    });
  }

  void _saveAttendance() {
    // сохранения посещаемости
  }

  @override
  Widget build(BuildContext context) {
    final double availableWidth = MediaQuery.of(context).size.width - 40;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок и кнопка
              _buildHeader(availableWidth),
              const SizedBox(height: 20),

              // Информация о занятии
              LessonInfoCard(
                lesson: _currentLesson,
                availableWidth: availableWidth,
              ),
              const SizedBox(height: 20),

              // Статистика
              StatisticsRow(
                availableWidth: availableWidth,
                totalStudents: totalStudents,
                presentCount: presentCount,
                absentCount: absentCount,
                notMarkedCount: notMarkedCount,
              ),
              const SizedBox(height: 30),

              _buildStudentsHeader(),
              const SizedBox(height: 16),

              // Список студентов
              Column(
                children: _students.map((student) {
                  return StudentCard(
                    student: student,
                    availableWidth: availableWidth,
                    onMarkPresent: () => _markPresent(student['id']),
                    onMarkAbsent: () => _markAbsent(student['id']),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Кнопка сохранения
              _buildSaveButton(availableWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double availableWidth) {
    return SizedBox(
      width: availableWidth,
      child: Row(
        children: [
          Expanded(
            child: const Text(
              'Посещаемость',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                fontFamily: 'TT Norms',
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 130,
            height: 32,
            child: ElevatedButton(
              onPressed: _markAllPresent,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.calendarButton,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.5),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              child: const Text(
                '+ отметить всех',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'TT Norms',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentsHeader() {
    return Text(
      'Список обучающихся:',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'Arial',
        color: AppColors.grayFieldText,
      ),
    );
  }

  Widget _buildSaveButton(double availableWidth) {
    return SizedBox(
      width: availableWidth,
      height: 56,
      child: ElevatedButton(
        onPressed: _saveAttendance,
        style: ElevatedButton.styleFrom(
          backgroundColor: notMarkedCount == 0
              ? AppColors.calendarButton
              : AppColors.eventTap,
          foregroundColor: notMarkedCount == 0
              ? AppColors.white
              : AppColors.calendarButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.5),
          ),
          side: BorderSide(
            color: notMarkedCount == 0
                ? AppColors.calendarButton
                : AppColors.calendarButton,
            width: 1,
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        child: Text(
          notMarkedCount == 0
              ? 'Сохранить посещаемость'
              : 'Сохранить ($notMarkedCount не отмечено)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'TT Norms',
            color: notMarkedCount == 0
                ? AppColors.white
                : AppColors.calendarButton,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
