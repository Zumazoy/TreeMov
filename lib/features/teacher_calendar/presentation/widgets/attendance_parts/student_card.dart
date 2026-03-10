import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';
import 'package:treemov/features/teacher_calendar/domain/entities/attendance_entity.dart';

class StudentCard extends StatelessWidget {
  final AttendanceEntity student;
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

  String _getAttendanceText(bool? status) {
    switch (status) {
      case true:
        return 'Присутствует';
      case false:
        return 'Отсутствует';
      default:
        return 'Не отмечено';
    }
  }

  Color _getAttendanceColor(bool? status) {
    switch (status) {
      case true:
        return AppColors.statsTotalText;
      case false:
        return AppColors.statsAbsentText;
      default:
        return AppColors.grayFieldText;
    }
  }

  Color _getAttendanceBackgroundColor(bool? status) {
    switch (status) {
      case true:
        return AppColors.statsTotalBg;
      case false:
        return AppColors.statsAbsentBg;
      default:
        return AppColors.white;
    }
  }

  Color _getAttendanceBorderColor(bool? status) {
    switch (status) {
      case true:
        return AppColors.statsTotalBorder;
      case false:
        return AppColors.statsAbsentBorder;
      default:
        return AppColors.lightGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final attendanceStatus = student.wasPresent;

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
              color: AppColors.directoryAvatarBackground,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: AppColors.directoryAvatarBorder,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person,
              color: AppColors.directoryTextSecondary,
              size: 28,
            ),
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
                  Text(student.name, style: AppTextStyles.ttNorms14W600.black),
                  const SizedBox(height: 2),

                  // Плашка статуса
                  Container(
                    constraints: const BoxConstraints(maxHeight: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: attendanceStatus == null
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
                      style: AppTextStyles.ttNorms10W500.copyWith(
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
                        color: attendanceStatus == true
                            ? AppColors.statsTotalText
                            : AppColors.lightGrey,
                        width: 1,
                      ),
                      color: attendanceStatus == true
                          ? AppColors.statsTotalBg
                          : AppColors.white,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/student_present.png',
                        width: 16,
                        height: 16,
                        color: attendanceStatus == true
                            ? AppColors.statsTotalText
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
                        color: attendanceStatus == false
                            ? AppColors.statsAbsentText
                            : AppColors.lightGrey,
                        width: 1,
                      ),
                      color: attendanceStatus == false
                          ? AppColors.statsAbsentBg
                          : AppColors.white,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/student_absent.png',
                        width: 16,
                        height: 16,
                        color: attendanceStatus == false
                            ? AppColors.statsAbsentText
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
