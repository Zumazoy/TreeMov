import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class StudentCard extends StatelessWidget {
  final Map<String, dynamic> student;
  final double availableWidth;
  final VoidCallback onMarkPresent;
  final VoidCallback onMarkAbsent;

  const StudentCard({
    super.key,
    required this.student,
    required this.availableWidth,
    required this.onMarkPresent,
    required this.onMarkAbsent,
  });

  String _getAttendanceText(String status) {
    switch (status) {
      case 'present':
        return 'Присутствует';
      case 'absent':
        return 'Отсутствует';
      default:
        return 'Не отмечено';
    }
  }

  Color _getAttendanceColor(String status) {
    switch (status) {
      case 'present':
        return const Color(0xFF166534);
      case 'absent':
        return const Color(0xFFDC2626);
      default:
        return AppColors.grayFieldText;
    }
  }

  Color _getAttendanceBackgroundColor(String status) {
    switch (status) {
      case 'present':
        return const Color(0xFFF0FDF4);
      case 'absent':
        return const Color(0xFFFEF2F2);
      default:
        return AppColors.white;
    }
  }

  Color _getAttendanceBorderColor(String status) {
    switch (status) {
      case 'present':
        return const Color(0xFFBBF7D0);
      case 'absent':
        return const Color(0xFFFECACA);
      default:
        return AppColors.lightGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final attendanceStatus = student['attendance'];

    return Container(
      width: availableWidth,
      height: 80,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getAttendanceBackgroundColor(attendanceStatus),
        borderRadius: BorderRadius.circular(12.5),
        border: Border.all(
          color: _getAttendanceBorderColor(attendanceStatus),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Аватарка
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightGrey,
              border: Border.all(
                color: _getAttendanceColor(attendanceStatus),
                width: 2,
              ),
            ),
            child: Icon(Icons.person, color: AppColors.grayFieldText, size: 24),
          ),

          const SizedBox(width: 12),

          // Имя и статус
          Expanded(
            child: SizedBox(
              height: 52,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    student['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'TT Norms',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // плашка статуса
                  Container(
                    constraints: const BoxConstraints(maxHeight: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: attendanceStatus == 'not_marked'
                          ? AppColors.white
                          : _getAttendanceBackgroundColor(attendanceStatus),
                      borderRadius: BorderRadius.circular(36),
                      border: Border.all(
                        color: _getAttendanceColor(attendanceStatus),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _getAttendanceText(attendanceStatus),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'TT Norms',
                        color: _getAttendanceColor(attendanceStatus),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Кнопки присутствия/отсутствия
          SizedBox(
            width: 92,
            height: 32,
            child: Row(
              children: [
                // Кнопка присутствия
                GestureDetector(
                  onTap: onMarkPresent,
                  child: Container(
                    width: 42,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.5),
                      border: Border.all(
                        color: attendanceStatus == 'present'
                            ? const Color(0xFF166534)
                            : AppColors.lightGrey,
                        width: 1,
                      ),
                      color: attendanceStatus == 'present'
                          ? const Color(0xFFF0FDF4)
                          : AppColors.white,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/student_present.png',
                        width: 16,
                        height: 16,
                        color: attendanceStatus == 'present'
                            ? const Color(0xFF166534)
                            : AppColors.grayFieldText,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Кнопка отсутствия
                GestureDetector(
                  onTap: onMarkAbsent,
                  child: Container(
                    width: 42,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.5),
                      border: Border.all(
                        color: attendanceStatus == 'absent'
                            ? const Color(0xFFDC2626)
                            : AppColors.lightGrey,
                        width: 1,
                      ),
                      color: attendanceStatus == 'absent'
                          ? const Color(0xFFFEF2F2)
                          : AppColors.white,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/student_absent.png',
                        width: 16,
                        height: 16,
                        color: attendanceStatus == 'absent'
                            ? const Color(0xFFDC2626)
                            : AppColors.grayFieldText,
                      ),
                    ),
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
