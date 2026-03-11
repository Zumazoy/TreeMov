import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_text_styles.dart';
import 'package:treemov/shared/domain/entities/lesson_entity.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_bloc.dart';

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
    final theme = Theme.of(context);

    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.only(
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
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: theme.dividerColor, width: 1),
              ),
            ),
            child: Center(
              child: Text(
                _formatDate(selectedDate),
                style: AppTextStyles.ttNorms16W600.themed(context),
              ),
            ),
          ),
          Expanded(
            child: events.isEmpty
                ? Center(
                    child: Text(
                      'На эту дату событий нет',
                      style: AppTextStyles.ttNorms14W400.copyWith(
                        color: theme.textTheme.bodySmall?.color,
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
