import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';
import 'package:treemov/features/teacher_calendar/domain/entities/lesson_entity.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_bloc.dart';
import 'package:treemov/features/teacher_calendar/presentation/screens/attendance_screen.dart';
import 'package:treemov/features/teacher_calendar/presentation/screens/lesson_details_screen.dart';

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
    final theme = Theme.of(context);

    final timeParts = event
        .formatTime(event.startTime, event.endTime)
        .split('\n');
    final startTime = timeParts.isNotEmpty ? timeParts[0] : '';
    final endTime = timeParts.length > 1 ? timeParts[1] : '';

    return Container(
      width: 355,
      height: 320,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 70,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(26),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.5),
                topRight: Radius.circular(12.5),
              ),
            ),
            child: Center(
              child: Text(
                event.group != null
                    ? 'Группа "${event.formatTitle(event.group?.title)}"'
                    : '(Не указан)',
                style: AppTextStyles.ttNorms16W600.themed(context),
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
              color: theme.cardColor,
              border: Border.all(color: theme.dividerColor, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRowWithIcon(
                  context,
                  'assets/images/activity_icon.png',
                  event.subject != null
                      ? event.formatTitle(event.subject?.title)
                      : '(Не указан)',
                ),
                _buildInfoRowWithIcon(
                  context,
                  'assets/images/place_icon.png',
                  event.classroom != null
                      ? event.formatTitle(event.classroom?.title)
                      : '(Не указана)',
                ),
                _buildInfoRowWithIcon(
                  context,
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
                      backgroundColor: theme.cardColor,
                      side: BorderSide(color: theme.dividerColor, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                    ),
                    child: Text(
                      'К событию',
                      style: AppTextStyles.ttNorms14W500.themed(context),
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
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                    ),
                    child: Text(
                      'Посещаемость',
                      style: AppTextStyles.ttNorms14W500.white,
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

  Widget _buildInfoRowWithIcon(
    BuildContext context,
    String iconPath,
    String value,
  ) {
    final theme = Theme.of(context);

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
              color: theme.iconTheme.color,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.ttNorms13W400.themed(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
