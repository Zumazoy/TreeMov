import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_response_model.dart';
import 'package:treemov/features/teacher_calendar/domain/entities/schedule_entity.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_bloc.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_event.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_state.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

import '../../../../core/themes/app_colors.dart';
import '../widgets/events_panel.dart';
import 'create_schedule_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate;

  Map<String, List<ScheduleEntity>> _events = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SchedulesBloc>().add(LoadSchedulesEvent());
    });
  }

  void _showEventsPanel(DateTime date) {
    final schedulesBloc = context.read<SchedulesBloc>();

    EventsPanel.show(
      context: context,
      selectedDate: date,
      events: _getEventsForDate(date),
      schedulesBloc: schedulesBloc,
    );
  }

  void _navigateToCreateSchedule() {
    final sharedRepository = getIt<SharedRepository>();
    final schedulesBloc = context.read<SchedulesBloc>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateScheduleScreen(
          sharedRepository: sharedRepository,
          schedulesBloc: schedulesBloc,
        ),
      ),
    );
  }

  List<ScheduleEntity> _getEventsForDate(DateTime date) {
    final String dateKey = _formatDate(date);
    return _events[dateKey] ?? [];
  }

  void _updateEventsFromSchedules(List<ScheduleResponseModel> schedules) {
    final Map<String, List<ScheduleEntity>> newEvents = {};

    for (final schedule in schedules) {
      final dateKey = _formatScheduleDate(schedule);

      if (!newEvents.containsKey(dateKey)) {
        newEvents[dateKey] = [];
      }

      newEvents[dateKey]!.add(
        ScheduleEntity(
          id: schedule.id,
          org: schedule.org,
          createdBy: schedule.createdBy,
          createdAt: schedule.createdAt,
          title: schedule.title,
          startTime: schedule.startTime,
          endTime: schedule.endTime,
          date: schedule.date,
          weekDay: schedule.weekDay,
          isCanceled: schedule.isCanceled,
          isCompleted: schedule.isCompleted,
          duration: schedule.duration,
          comment: schedule.comment,
          periodSchedule: schedule.periodSchedule,
          teacher: schedule.teacher,
          subject: schedule.subject,
          group: schedule.group,
          classroom: schedule.classroom,
        ),
      );
    }

    setState(() {
      _events = newEvents;
    });
  }

  String _formatScheduleDate(ScheduleResponseModel schedule) {
    try {
      final date = DateTime.parse(schedule.date!);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return schedule.date!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SchedulesBloc, ScheduleState>(
      listener: (context, state) {
        if (state is SchedulesLoaded) {
          _updateEventsFromSchedules(state.schedules);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Text(
            'Календарь',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Arial',
              color: Colors.black,
            ),
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                  fontFamily: 'TT Norms',
                                  height: 1.2,
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
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _navigateToCreateSchedule,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.plusButton,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.5),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
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
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'TT Norms',
              color: Colors.black,
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
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.calendarButton
                      : (isToday
                            ? AppColors.todayBackground
                            : Colors.transparent),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    day.day.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected || isToday
                          ? AppColors.white
                          : Colors.black,
                      fontFamily: 'TT Norms',
                    ),
                  ),
                ),
              ),
              if (hasEvents)
                Positioned(
                  bottom: 2,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.calendarButton,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
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
