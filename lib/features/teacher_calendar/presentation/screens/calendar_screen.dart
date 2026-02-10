import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/features/teacher_calendar/domain/entities/lesson_entity.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_bloc.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_event.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_state.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

import '../../../../core/themes/app_colors.dart';
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

  void _showEventsPanel(DateTime date) {
    final schedulesBloc = context.read<SchedulesBloc>();

    EventsPanel.show(
      context: context,
      selectedDate: date,
      events: _getEventsForDate(date),
      schedulesBloc: schedulesBloc,
    );
  }

  void _navigateToCreateLessons() {
    final sharedRepository = getIt<SharedRepository>();
    final schedulesBloc = context.read<SchedulesBloc>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateLessonScreen(
          sharedRepository: sharedRepository,
          schedulesBloc: schedulesBloc,
        ),
      ),
    );
  }

  List<LessonEntity> _getEventsForDate(DateTime date) {
    final String dateKey = _formatDate(date);
    return _events[dateKey] ?? [];
  }

  void _updateEventsFromLessons(List<LessonResponseModel> lessons) {
    final Map<String, List<LessonEntity>> newEvents = {};

    for (final lesson in lessons) {
      final dateKey = _formatLessonDate(lesson);

      if (!newEvents.containsKey(dateKey)) {
        newEvents[dateKey] = [];
      }

      newEvents[dateKey]!.add(
        LessonEntity(
          id: lesson.id,
          org: lesson.org,
          createdBy: lesson.createdBy,
          createdAt: lesson.createdAt,
          title: lesson.title,
          startTime: lesson.startTime,
          endTime: lesson.endTime,
          date: lesson.date,
          weekDay: lesson.weekDay,
          isCanceled: lesson.isCanceled,
          isCompleted: lesson.isCompleted,
          duration: lesson.duration,
          comment: lesson.comment,
          periodSchedule: lesson.periodSchedule,
          periodLesson: lesson.periodLesson,
          teacher: lesson.teacher,
          subject: lesson.subject,
          group: lesson.group,
          classroom: lesson.classroom,
        ),
      );
    }

    setState(() {
      _events = newEvents;
    });
  }

  String _formatLessonDate(LessonResponseModel lesson) {
    try {
      final date = DateTime.parse(lesson.date!);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return lesson.date!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SchedulesBloc, ScheduleState>(
      listener: (context, state) {
        if (state is LessonsLoaded) {
          _updateEventsFromLessons(state.lessons);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/calendar_simple_icon.png',
                width: 24,
                height: 24,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                'Календарь',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Arial',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 327,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.calendarButton,
                          borderRadius: BorderRadius.circular(12.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.chevron_left,
                                color: AppColors.white,
                                size: 24,
                              ),
                              onPressed: () {
                                setState(() {
                                  _currentDate = DateTime(
                                    _currentDate.year,
                                    _currentDate.month - 1,
                                  );
                                });
                              },
                            ),
                            Center(
                              child: Text(
                                _getMonthYearText(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                  fontFamily: 'Arial',
                                  height: 1.0,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.chevron_right,
                                color: AppColors.white,
                                size: 24,
                              ),
                              onPressed: () {
                                setState(() {
                                  _currentDate = DateTime(
                                    _currentDate.year,
                                    _currentDate.month + 1,
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: 327,
                        height: 40,
                        child: Row(children: _buildWeekDays()),
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        width: 327,
                        height: _calculateCalendarHeight(),
                        child: _buildCalendarGrid(),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 60, right: 60, bottom: 10),
            child: ElevatedButton(
              onPressed: _navigateToCreateLessons,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.plusButton,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.5),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              child: const Text(
                'Добавить событие',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'TT Norms',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  List<Widget> _buildWeekDays() {
    const List<String> weekDays = ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ', 'ВС'];

    return weekDays.map((day) {
      return Expanded(
        child: Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(
            day,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Arial',
              color: AppColors.violet800WithOpacity,
              height: 1.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildCalendarGrid() {
    final List<DateTime?> calendarDays = _generateCurrentMonthDays();

    return GridView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: calendarDays.length,
      itemBuilder: (context, index) {
        final day = calendarDays[index];

        if (day == null) {
          return Container();
        }

        final isSelected =
            _selectedDate != null &&
            day.year == _selectedDate!.year &&
            day.month == _selectedDate!.month &&
            day.day == _selectedDate!.day;
        final isToday = _isToday(day);
        final hasEvents = _events.containsKey(_formatDate(day));

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = day;
            });
            _showEventsPanel(day);
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: isToday
                  ? Border.all(color: AppColors.teacherPrimary, width: 1)
                  : null,
              borderRadius: BorderRadius.circular(8),
              color: isSelected
                  ? AppColors.selectedDateBackground
                  : Colors.transparent,
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    day.day.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Arial',
                      height: 1.0,
                      color: AppColors.notesDarkText,
                    ),
                  ),
                ),
                if (hasEvents)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: AppColors.calendarButton, // #7A75FF
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<DateTime?> _generateCurrentMonthDays() {
    final List<DateTime?> days = [];

    final firstDay = DateTime(_currentDate.year, _currentDate.month, 1);
    final lastDay = DateTime(_currentDate.year, _currentDate.month + 1, 0);

    int firstWeekday = firstDay.weekday;
    if (firstWeekday == 7) firstWeekday = 0;

    for (int i = 0; i < firstWeekday; i++) {
      days.add(null);
    }

    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(_currentDate.year, _currentDate.month, i));
    }

    return days;
  }

  double _calculateCalendarHeight() {
    final firstDay = DateTime(_currentDate.year, _currentDate.month, 1);
    final lastDay = DateTime(_currentDate.year, _currentDate.month + 1, 0);

    int firstWeekday = firstDay.weekday;
    if (firstWeekday == 7) firstWeekday = 0;

    final totalCells = lastDay.day + firstWeekday;
    final weeks = (totalCells / 7).ceil();

    return weeks * 56.0;
  }

  String _getMonthYearText() {
    final months = [
      'Январь',
      'Февраль',
      'Март',
      'Апрель',
      'Май',
      'Июнь',
      'Июль',
      'Август',
      'Сентябрь',
      'Октябрь',
      'Ноябрь',
      'Декабрь',
    ];
    return '${months[_currentDate.month - 1]} ${_currentDate.year}';
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
