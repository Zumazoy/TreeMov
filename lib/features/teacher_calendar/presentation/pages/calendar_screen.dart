import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../data/models/calendar_event.dart';
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

  final Map<String, List<CalendarEvent>> _events = {
    '2025-10-29': [
      CalendarEvent(
        time: '18:30\n20:00',
        title: 'Растяжка (Группа "Слайд")',
        location: 'Малый зал',
      ),
      CalendarEvent(
        time: '19:45\n21:15',
        title: 'Йога для начинающих',
        location: 'Большой зал',
      ),
    ],
    '2025-10-25': [
      CalendarEvent(
        time: '16:00\n17:30',
        title: 'Фитнес микс',
        location: 'Большой зал',
      ),
    ],
    '2025-10-22': [
      CalendarEvent(
        time: '09:00\n10:30',
        title: 'Утренняя зарядка',
        location: 'Малый зал',
      ),
      CalendarEvent(
        time: '14:00\n15:30',
        title: 'Стретчинг',
        location: 'Большой зал',
      ),
      CalendarEvent(
        time: '19:00\n20:30',
        title: 'Силовая тренировка',
        location: 'Тренажерный зал',
      ),
    ],
  };

  void _showEventsPanel(DateTime date) {
    EventsPanel.show(
      context: context,
      selectedDate: date,
      events: _getEventsForDate(date),
    );
  }

  void _navigateToCreateSchedule() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateScheduleScreen()),
    );
  }

  List<CalendarEvent> _getEventsForDate(DateTime date) {
    final String dateKey = _formatDate(date);
    return _events[dateKey] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.plusButton,
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.all(5),
                    icon: const Icon(Icons.add, color: Colors.white, size: 15),
                    onPressed: _navigateToCreateSchedule,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

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
