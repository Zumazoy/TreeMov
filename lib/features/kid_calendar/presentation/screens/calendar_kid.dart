import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/features/kid_calendar/domain/entities/kid_event_entity.dart';
import 'package:treemov/features/kid_calendar/presentation/bloc/kid_calendar_bloc.dart';
import 'package:treemov/features/kid_calendar/presentation/bloc/kid_calendar_event.dart';
import 'package:treemov/features/kid_calendar/presentation/bloc/kid_calendar_state.dart';
import 'package:treemov/features/kid_calendar/presentation/widgets/kid_lesson_card.dart';

class CalendarKidScreen extends StatefulWidget {
  const CalendarKidScreen({super.key});

  @override
  State<CalendarKidScreen> createState() => _CalendarKidScreenState();
}

class _CalendarKidScreenState extends State<CalendarKidScreen> {
  DateTime _currentDate = DateTime.now();
  int _selectedDay = DateTime.now().day;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? _lessonsSheetController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        context.read<KidCalendarBloc>().add(LoadKidCalendar());
      } catch (_) {}
    });
  }

  void _previousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
    });
    try {
      context.read<KidCalendarBloc>().add(LoadKidCalendar());
    } catch (_) {}
  }

  void _nextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
    });
    try {
      context.read<KidCalendarBloc>().add(LoadKidCalendar());
    } catch (_) {}
  }

  String _getMonthYearString(DateTime date) {
    const months = [
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
    return '${months[date.month - 1]} ${date.year}';
  }

  Widget _buildCalendarTable(Set<int> lessonDays, List<KidEventEntity> events) {
    final firstDay = DateTime(_currentDate.year, _currentDate.month, 1);
    final startingWeekday = firstDay.weekday;
    final daysInMonth = DateTime(
      _currentDate.year,
      _currentDate.month + 1,
      0,
    ).day;

    final int offset = startingWeekday - 1;
    final int totalCells = offset + daysInMonth;
    final int rows = (totalCells / 7).ceil();

    List<TableRow> tableRows = [];

    tableRows.add(
      TableRow(
        children: List.generate(7, (i) {
          const names = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
          return SizedBox(
            height: 32,
            child: Center(
              child: Text(
                names[i],
                style: const TextStyle(
                  color: Color(0xFF004C75),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        }),
      ),
    );

    int dayCounter = 1;

    for (int r = 0; r < rows; r++) {
      List<Widget> rowChildren = [];

      for (int c = 0; c < 7; c++) {
        final cellIndex = r * 7 + c;

        if (cellIndex < offset) {
          rowChildren.add(const SizedBox(height: 48));
        } else if (dayCounter <= daysInMonth) {
          final int day = dayCounter;
          final bool hasLesson = lessonDays.contains(day);
          final bool isSelected = day == _selectedDay;
          final bool isToday =
              day == DateTime.now().day &&
              _currentDate.month == DateTime.now().month &&
              _currentDate.year == DateTime.now().year;

          rowChildren.add(
            GestureDetector(
              onTap: () {
                final wasSelected = _selectedDay == day;
                setState(() => _selectedDay = wasSelected ? -1 : day);

                try {
                  context.read<KidCalendarBloc>().add(SelectKidDay(day));
                } catch (_) {}

                final lessonsForDay = events
                    .where((e) => e.day == day)
                    .toList();

                if (lessonsForDay.isNotEmpty) {
                  _showLessonsPanel(lessonsForDay);
                } else {
                  _lessonsSheetController?.close();
                  _lessonsSheetController = null;
                }
              },
              child: SizedBox(
                height: 48,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF0087CD)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: isToday
                            ? Border.all(
                                color: const Color(0xFF0087CD),
                                width: 2,
                              )
                            : null,
                      ),
                      child: Text(
                        '$day',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'TT Norms',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (hasLesson)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF004C75),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );

          dayCounter++;
        } else {
          rowChildren.add(const SizedBox(height: 48));
        }
      }

      tableRows.add(TableRow(children: rowChildren));
    }

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: tableRows,
    );
  }

  void _showLessonsPanel(List<KidEventEntity> lessons) {
    if (_lessonsSheetController != null) return;

    _lessonsSheetController = _scaffoldKey.currentState?.showBottomSheet((_) {
      return Container(
        height: 360,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
        ),
        child: SafeArea(
          top: true,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFF004C75),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: lessons.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, idx) => KidLessonCard(event: lessons[idx]),
                ),
              ),
            ],
          ),
        ),
      );
    }, backgroundColor: Colors.transparent);

    _lessonsSheetController?.closed.then((_) {
      _lessonsSheetController = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF75D0FF),
      appBar: AppBar(
        title: const Text(
          'Календарь',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'TT Norms',
          ),
        ),
        backgroundColor: const Color(0xFF75D0FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<KidCalendarBloc, KidCalendarState>(
        builder: (context, state) {
          final events = state.events;
          final lessonDays = state.lessonDays;

          if (state.selectedDay != null) {
            _selectedDay = state.selectedDay!;
          }

          return LayoutBuilder(
            builder: (_, constraints) {
              final maxWidth = constraints.maxWidth > 600
                  ? 600.0
                  : constraints.maxWidth * 0.92;

              return Center(
                child: SizedBox(
                  width: maxWidth,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),

                      Container(
                        height: 48,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF004C75),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: _previousMonth,
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 18,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  _getMonthYearString(_currentDate),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'TT Norms',
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: _nextMonth,
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 18,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      Expanded(
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              _buildCalendarTable(lessonDays, events),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
