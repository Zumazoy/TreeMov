import 'package:flutter/material.dart';
import 'package:treemov/features/teacher_calendar/domain/entities/lesson_entity.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_bloc.dart';

import '../../../../core/themes/app_colors.dart';
import 'event_details_modal.dart';
import 'lesson_event_card.dart';

class EventsPanel extends StatelessWidget {
  final DateTime selectedDate;
  final List<LessonEntity> events;
  final SchedulesBloc schedulesBloc;

  const EventsPanel({
    super.key,
    required this.selectedDate,
    required this.events,
    required this.schedulesBloc,
  });

  static void show({
    required BuildContext context,
    required DateTime selectedDate,
    required List<LessonEntity> events,
    required SchedulesBloc schedulesBloc,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EventsPanel(
        selectedDate: selectedDate,
        events: events,
        schedulesBloc: schedulesBloc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.5),
          topRight: Radius.circular(12.5),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.teacherPrimary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1),
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
                      return LessonEventCard(
                        event: events[index],
                        onTap: () => _showEventDetails(context, events[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showEventDetails(BuildContext context, LessonEntity event) {
    Navigator.pop(context);
    EventDetailsModal.show(
      context: context,
      event: event,
      schedulesBloc: schedulesBloc,
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
