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

  Color _getAttendanceColor(bool? status, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (status) {
      case true:
        return isDark
            ? AppColors.darkCategoryStudyText
            : AppColors.statsTotalText;
      case false:
        return isDark
            ? AppColors.darkCategoryGeneralText
            : AppColors.statsAbsentText;
      default:
        return isDark ? AppColors.darkTextSecondary : AppColors.grayFieldText;
    }
  }

  Color _getAttendanceBackgroundColor(bool? status, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (status) {
      case true:
        return isDark ? AppColors.darkCategoryStudyBg : AppColors.statsTotalBg;
      case false:
        return isDark
            ? AppColors.darkCategoryGeneralBg
            : AppColors.statsAbsentBg;
      default:
        return isDark ? AppColors.darkCard : AppColors.white;
    }
  }

  Color _getAttendanceBorderColor(bool? status, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (status) {
      case true:
        return isDark ? AppColors.darkSurface : AppColors.statsTotalBorder;
      case false:
        return isDark ? AppColors.darkSurface : AppColors.statsAbsentBorder;
      default:
        return isDark ? AppColors.darkSurface : AppColors.lightGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final attendanceStatus = student.wasPresent;

    final avatarBgColor = isDark
        ? AppColors.darkCard
        : AppColors.directoryAvatarBackground;
    final avatarBorderColor = isDark
        ? AppColors.darkSurface
        : AppColors.directoryAvatarBorder;
    final avatarIconColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.directoryTextSecondary;

    final nameColor = isDark ? AppColors.darkText : Colors.black;

    final presentButtonBgColor = attendanceStatus == true
        ? (isDark ? AppColors.darkCategoryStudyBg : AppColors.statsTotalBg)
        : (isDark ? AppColors.darkCard : AppColors.white);

    final presentButtonBorderColor = attendanceStatus == true
        ? (isDark ? AppColors.darkCategoryStudyText : AppColors.statsTotalText)
        : (isDark ? AppColors.darkSurface : AppColors.lightGrey);

    final presentIconColor = attendanceStatus == true
        ? (isDark ? AppColors.darkCategoryStudyText : AppColors.statsTotalText)
        : (isDark ? AppColors.darkTextSecondary : AppColors.grayFieldText);

    final absentButtonBgColor = attendanceStatus == false
        ? (isDark ? AppColors.darkCategoryGeneralBg : AppColors.statsAbsentBg)
        : (isDark ? AppColors.darkCard : AppColors.white);

    final absentButtonBorderColor = attendanceStatus == false
        ? (isDark
              ? AppColors.darkCategoryGeneralText
              : AppColors.statsAbsentText)
        : (isDark ? AppColors.darkSurface : AppColors.lightGrey);

    final absentIconColor = attendanceStatus == false
        ? (isDark
              ? AppColors.darkCategoryGeneralText
              : AppColors.statsAbsentText)
        : (isDark ? AppColors.darkTextSecondary : AppColors.grayFieldText);

    return Container(
      width: availableWidth,
      height: 80,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getAttendanceBackgroundColor(attendanceStatus, context),
        borderRadius: BorderRadius.circular(12.5),
        border: Border.all(
          color: _getAttendanceBorderColor(attendanceStatus, context),
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
              color: avatarBgColor,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: avatarBorderColor, width: 2),
            ),
            child: Icon(Icons.person, color: avatarIconColor, size: 28),
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
                    student.name,
                    style: AppTextStyles.ttNorms14W600.copyWith(
                      color: nameColor,
                    ),
                  ),
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
                          ? (isDark ? AppColors.darkCard : AppColors.white)
                          : _getAttendanceBackgroundColor(
                              attendanceStatus,
                              context,
                            ),
                      borderRadius: BorderRadius.circular(36),
                      border: Border.all(
                        color: _getAttendanceColor(attendanceStatus, context),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _getAttendanceText(attendanceStatus),
                      style: AppTextStyles.ttNorms10W500.copyWith(
                        color: _getAttendanceColor(attendanceStatus, context),
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
                        color: presentButtonBorderColor,
                        width: 1,
                      ),
                      color: presentButtonBgColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/student_present.png',
                        width: 16,
                        height: 16,
                        color: presentIconColor,
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
                        color: absentButtonBorderColor,
                        width: 1,
                      ),
                      color: absentButtonBgColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/student_absent.png',
                        width: 16,
                        height: 16,
                        color: absentIconColor,
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
