import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/features/teacher_calendar/domain/entities/lesson_entity.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_bloc.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_event.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_state.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

import '../../../../core/themes/app_colors.dart';
import '../utils/calendar_utils.dart';
import '../widgets/calendar/add_event_button.dart';
import '../widgets/calendar/calendar_app_bar.dart';
import '../widgets/calendar/calendar_grid.dart';
import '../widgets/calendar/calendar_header.dart';
import '../widgets/calendar/calendar_week_days.dart';
import '../widgets/events_panel.dart';
import 'create_lesson_screen.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SchedulesBloc>()..add(LoadLessonsEvent()),
      child: const _CalendarScreenContent(),
    );
  }
}

class _CalendarScreenContent extends StatefulWidget {
  const _CalendarScreenContent();

  @override
  State<_CalendarScreenContent> createState() => _CalendarScreenContentState();
}

class _CalendarScreenContentState extends State<_CalendarScreenContent> {
  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate;
  Map<String, List<LessonEntity>> _events = {};

  void _changeMonth(int offset) {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + offset);
    });
  }

  void _showEventsPanel(DateTime date) {
    final schedulesBloc = context.read<SchedulesBloc>();
    EventsPanel.show(
      context: context,
      selectedDate: date,
      events: _events[CalendarUtils.formatDateKey(date)] ?? [],
      schedulesBloc: schedulesBloc,
    );
  }

  void _navigateToCreateLessons() {
    final schedulesBloc = context.read<SchedulesBloc>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreateLessonScreen(
          sharedRepository: getIt<SharedRepository>(),
          schedulesBloc: schedulesBloc,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SchedulesBloc, ScheduleState>(
      listener: (context, state) {
        if (state is LessonsLoaded) {
          setState(() {
            _events = CalendarUtils.groupLessonsByDate(state.lessons);
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CalendarAppBar(),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  // 1. Растягиваем на всю ширину
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // 2. Центрируем элементы
                    children: [
                      CalendarHeader(
                        currentDate: _currentDate,
                        onPrevMonth: () => _changeMonth(-1),
                        onNextMonth: () => _changeMonth(1),
                      ),
                      const SizedBox(height: 20),
                      const CalendarWeekDays(),
                      const SizedBox(height: 10),
                      CalendarGrid(
                        currentDate: _currentDate,
                        selectedDate: _selectedDate,
                        eventDates: _events.keys.toSet(),
                        onDateSelected: (date) {
                          setState(() => _selectedDate = date);
                          _showEventsPanel(date);
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: AddEventButton(
          onPressed: _navigateToCreateLessons,
        ),
      ),
    );
  }
}
