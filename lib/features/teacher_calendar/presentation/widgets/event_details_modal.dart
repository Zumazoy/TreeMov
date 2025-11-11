import 'package:flutter/material.dart';
import 'package:treemov/features/teacher_calendar/domain/entities/calendar_event_entity.dart';
import 'package:treemov/features/teacher_calendar/presentation/screens/about_event_details.dart';
import 'package:treemov/features/teacher_calendar/presentation/screens/attendance_screen.dart';

import '../../../../core/themes/app_colors.dart';

class EventDetailsModal extends StatelessWidget {
  final CalendarEventEntity event;

  const EventDetailsModal({super.key, required this.event});

  static void show({
    required BuildContext context,
    required CalendarEventEntity event,
  }) {
    showDialog(
      context: context,
      barrierColor: AppColors.dialogBarrier,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: EventDetailsModal(event: event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final timeParts = event.time.split('\n');
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
                event.title,
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
                  _extractActivityType(event.title),
                ),
                _buildInfoRowWithIcon(
                  'assets/images/place_icon.png',
                  event.location,
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
                          builder: (context) => AboutEventDetailsScreen(
                            groupName: event.title,
                            activityType: _extractActivityType(event.title),
                            location: event.location,
                            startTime: startTime,
                            endTime: endTime,
                            repeat: 'Еженедельно',
                            description:
                                event.description ??
                                'Описание события отсутствует',
                          ),
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
                          builder: (context) => AttendanceScreen(),
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

  String _extractActivityType(String title) {
    final bracketIndex = title.indexOf('(');
    if (bracketIndex > 0) {
      return title.substring(0, bracketIndex).trim();
    }
    return title;
  }
}
