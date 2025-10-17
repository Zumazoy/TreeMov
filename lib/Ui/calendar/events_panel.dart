import 'package:flutter/material.dart';
import '../../../models/calendar_event.dart';
import '../../constants/app_colors.dart';
import 'event_details_modal.dart';

class EventsPanel extends StatelessWidget {
  final DateTime selectedDate;
  final List<CalendarEvent> events;

  const EventsPanel({
    super.key,
    required this.selectedDate,
    required this.events,
  });

  static void show({
    required BuildContext context,
    required DateTime selectedDate,
    required List<CalendarEvent> events,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EventsPanel(
        selectedDate: selectedDate,
        events: events,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.5),
          topRight: Radius.circular(12.5),
        ),
        border: Border.all(
          color: AppColors.eventTap,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 30,
            alignment: Alignment.center,
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.teacherPrimary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: Center(
              child: Text(
                _formatDate(selectedDate),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'TT Norms',
                ),
              ),
            ),
          ),

          Expanded(
            child: events.isEmpty
                ? const Center(
                    child: Text(
                      'На эту дату событий нет',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grey,
                        fontFamily: 'TT Norms',
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return _buildEventItem(events[index], context);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventItem(CalendarEvent event, BuildContext context) {
    final timeParts = event.time.split('\n');
    final startTime = timeParts.isNotEmpty ? timeParts[0] : '';
    final endTime = timeParts.length > 1 ? timeParts[1] : '';

    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.eventTap,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  startTime,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'TT Norms',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  endTime,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'TT Norms',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 2,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2F213E),
              borderRadius: BorderRadius.circular(4.5),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'TT Norms',
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.location,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                      fontFamily: 'TT Norms',
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),

          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(right: 16),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Image.asset(
                'assets/images/purple_arrow.png',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              onPressed: () {
                _showEventDetails(context, event);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEventDetails(BuildContext context, CalendarEvent event) {
    Navigator.pop(context);
    EventDetailsModal.show(
      context: context,
      event: event,
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
      'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}