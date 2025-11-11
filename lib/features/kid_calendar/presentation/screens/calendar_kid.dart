import 'package:flutter/material.dart';

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

  // Дни с занятиями (точки)
  final Set<int> _daysWithLessons = {
    1,
    3,
    5,
    10,
    12,
    15,
    17,
    19,
    22,
    24,
    26,
    29,
    31,
  };

  void _previousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
    });
  }

  String _getMonthName(DateTime date) {
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
    return months[date.month - 1];
  }

  List<Widget> _buildCalendarDays() {
    final firstDay = DateTime(_currentDate.year, _currentDate.month, 1);
    final startingWeekday = firstDay.weekday; // 1-7 (понедельник-воскресенье)

    // Количество дней в месяце
    final daysInMonth = DateTime(
      _currentDate.year,
      _currentDate.month + 1,
      0,
    ).day;

    List<Widget> dayWidgets = [];

    // Добавляем пустые ячейки для дней предыдущего месяца
    for (int i = 1; i < startingWeekday; i++) {
      dayWidgets.add(Container());
    }

    // Добавляем дни текущего месяца
    for (int day = 1; day <= daysInMonth; day++) {
      final hasLesson = _daysWithLessons.contains(day);
      final isSelected = day == _selectedDay;
      final isToday =
          day == DateTime.now().day &&
          _currentDate.month == DateTime.now().month &&
          _currentDate.year == DateTime.now().year;

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            final bool wasSelected = _selectedDay == day;
            setState(() {
              _selectedDay = wasSelected ? -1 : day;
            });

            if (wasSelected) {
              if (_lessonsSheetController != null) {
                _lessonsSheetController!.close();
                _lessonsSheetController = null;
              }
              return;
            }

            if (hasLesson) {
              _showLessonsPanel(day);
            } else {
              if (_lessonsSheetController != null) {
                _lessonsSheetController!.close();
                _lessonsSheetController = null;
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0087CD) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isToday
                  ? Border.all(color: const Color(0xFF0087CD), width: 2)
                  : null,
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 0,
              children: [
                SizedBox(height: 8),
                Text(
                  day.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'TT Norms',
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 8,
                  child: hasLesson
                      ? Transform.translate(
                          offset: const Offset(0, -2),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF004C75),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return dayWidgets;
  }

  void _showLessonsPanel(int day) {
    if (_lessonsSheetController != null) {
      setState(() {});
      return;
    }
    _lessonsSheetController = _scaffoldKey.currentState?.showBottomSheet(
      (context) {
        return Container(
          height: 360,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.5)),
          ),
          child: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 53,
                    height: 7,
                    decoration: BoxDecoration(
                      color: const Color(0xFF004C75),
                      borderRadius: BorderRadius.circular(4.5),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 36, right: 28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildLessonItem(
                        '18:30',
                        '20:00',
                        'Растяжка',
                        'О.А. Зеленина',
                        'Малый зал',
                      ),
                      const SizedBox(height: 20),
                      _buildLessonItem(
                        '20:15',
                        '21:00',
                        'Аэробика',
                        'И.И. Иванова',
                        'Большой зал',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      backgroundColor: Colors.transparent,
      elevation: 8,
    );
    _lessonsSheetController?.closed.whenComplete(() {
      _lessonsSheetController = null;
    });
  }

  Widget _buildLessonItem(
    String startTime,
    String endTime,
    String title,
    String teacher,
    String room,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Времена (старт сверху жирным, окончание ниже полупрозрачным)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              startTime,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Color(0xFF004C75),
                fontFamily: 'TT Norms',
              ),
            ),
            Text(
              endTime,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Color(0xFF004C75) /*.withOpacity(0.5)*/,
                fontFamily: 'TT Norms',
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        // Вертикальная разделительная линия
        Container(
          width: 2,
          height: 30,
          color: const Color(0xFF004C75),
          margin: const EdgeInsets.only(top: 2),
        ),
        const SizedBox(width: 9),
        // Контент занятия
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title ($teacher)',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF004C75),
                  fontFamily: 'TT Norms',
                ),
              ),
              Text(
                room,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF004C75),
                  fontFamily: 'TT Norms',
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Верхний синий прямоугольник с месяцем и стрелками
          Container(
            width: 327,
            height: 38,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF004C75),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Стрелка влево
                IconButton(
                  onPressed: _previousMonth,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                // Название месяца
                Text(
                  _getMonthName(_currentDate),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'TT Norms',
                  ),
                ),
                // Стрелка вправо
                IconButton(
                  onPressed: _nextMonth,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Основной контент календаря
          Expanded(
            child: Container(
              width: 327,
              decoration: const BoxDecoration(
                color: Color(0xFF75D0FF),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  // Сетка календаря
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 7,
                      childAspectRatio: 0.92,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      children: _buildCalendarDays(),
                    ),
                  ),

                  // Нижний отступ
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
