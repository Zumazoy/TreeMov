import 'package:flutter/material.dart';
import 'package:treemov/features/teacher_calendar/domain/entities/lesson_entity.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_bloc.dart';
import 'package:treemov/features/teacher_calendar/presentation/screens/attendance_screen.dart';
import 'package:treemov/features/teacher_calendar/presentation/screens/lesson_details_screen.dart';

import '../../../../core/themes/app_colors.dart';

class EventDetailsModal extends StatelessWidget {
  final LessonEntity event;
  final SchedulesBloc schedulesBloc;

  const EventDetailsModal({
    super.key,
    required this.event,
    required this.schedulesBloc,
  });

  static void show({
    required BuildContext context,
    required LessonEntity event,
    required SchedulesBloc schedulesBloc,
  }) {
    showDialog(
      context: context,
      barrierColor: AppColors.dialogBarrier,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: EventDetailsModal(event: event, schedulesBloc: schedulesBloc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final timeParts = event
        .formatTime(event.startTime, event.endTime)
        .split('\n');
    final startTime = timeParts.isNotEmpty ? timeParts[0] : '';
    final endTime = timeParts.length > 1 ? timeParts[1] : '';

    return Container(
      width: 355,
      height: 320,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 70,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.eventTap,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.5),
                topRight: Radius.circular(12.5),
              ),
            ),
            child: Center(
              child: Text(
                event.group != null
                    ? 'Группа "${event.formatTitle(event.group?.name)}"'
                    : '(Не указан)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'TT Norms',
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 140,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRowWithIcon(
                  'assets/images/activity_icon.png',
                  event.subject != null
                      ? event.formatTitle(event.subject?.name)
                      : '(Не указан)',
                ),
                _buildInfoRowWithIcon(
                  'assets/images/place_icon.png',
                  event.classroom != null
                      ? event.formatTitle(event.classroom?.title)
                      : '(Не указана)',
                ),
                _buildInfoRowWithIcon(
                  'assets/images/clock_icon.png',
                  '$startTime-$endTime',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 160,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LessonDetailsScreen(event: event),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      side: const BorderSide(
                        color: Color(0xFF616161),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                    ),
                    child: const Text(
                      'К событию',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'TT Norms',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 160,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttendanceScreen(
                            lesson: event,
                            schedulesBloc: schedulesBloc,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teacherPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                    ),
                    child: const Text(
                      'Посещаемость',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'TT Norms',
                        color: AppColors.white,
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

  Widget _buildInfoRowWithIcon(String iconPath, String value) {
    return SizedBox(
      height: 32,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 32,
            child: Image.asset(
              iconPath,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: 'TT Norms',
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
