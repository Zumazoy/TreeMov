import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/features/teacher_calendar/domain/entities/lesson_entity.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_bloc.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_event.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_state.dart';
import 'package:treemov/features/teacher_calendar/presentation/utils/calendar_utils.dart';

import '../../../../../core/themes/app_colors.dart';

class CalendarKidScreen extends StatelessWidget {
  const CalendarKidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<SchedulesBloc>()..add(const LoadLessonsEvent()),
      child: const _CalendarKidScreenContent(),
    );
  }
}

class _CalendarKidScreenContent extends StatefulWidget {
  const _CalendarKidScreenContent();

  @override
  State<_CalendarKidScreenContent> createState() =>
      _CalendarKidScreenContentState();
}

class _CalendarKidScreenContentState extends State<_CalendarKidScreenContent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? _lessonsSheetController;
  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate;
  Map<String, List<LessonEntity>> _events = {};

  String _getMonthYearText(DateTime date) {
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

  void _changeMonth(int offset) {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + offset);
    });
  }

  void _processLessons(List<LessonEntity> lessons) {
    final Map<String, List<LessonEntity>> events = {};

    for (final lesson in lessons) {
      if (lesson.date != null) {
        final dateKey = CalendarUtils.formatDateKey(
          DateTime.parse(lesson.date!),
        );
        if (!events.containsKey(dateKey)) {
          events[dateKey] = [];
        }
        events[dateKey]!.add(lesson);
      }
    }

    setState(() {
      _events = events;
    });
  }

  void _showLessonsPanel(DateTime date) {
    if (_lessonsSheetController != null) return;

    final dateKey = CalendarUtils.formatDateKey(date);
    final lessons = _events[dateKey] ?? [];

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
                    margin: const EdgeInsets.only(top: 10),
                    width: 53,
                    height: 7,
                    decoration: BoxDecoration(
                      color: AppColors.kidButton,
                      borderRadius: BorderRadius.circular(4.5),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 36, right: 28),
                  child: lessons.isEmpty
                      ? const Center(
                          child: Text(
                            'На этот день нет занятий',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.kidButton,
                              fontFamily: 'TT Norms',
                            ),
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: lessons.map((lesson) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: _buildLessonItem(lesson),
                            );
                          }).toList(),
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
      if (mounted) {
        _lessonsSheetController = null;
        setState(() {
          _selectedDate = null;
        });
      }
    });
  }

  Widget _buildLessonItem(LessonEntity lesson) {
    final startTime = lesson.startTime?.substring(0, 5) ?? '--:--';
    final endTime = lesson.endTime?.substring(0, 5) ?? '--:--';

    String teacherName = 'Преподаватель';
    if (lesson.teacher?.employee.name != null ||
        lesson.teacher?.employee.surname != null) {
      final parts = [
        lesson.teacher?.employee.surname,
        lesson.teacher?.employee.name,
      ].where((part) => part != null && part.isNotEmpty).toList();

      if (parts.isNotEmpty) {
        teacherName = parts.join(' ');

        if (lesson.teacher?.employee.patronymic != null &&
            lesson.teacher!.employee.patronymic!.isNotEmpty) {
          teacherName += ' ${lesson.teacher!.employee.patronymic![0]}.';
        }
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              startTime,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: AppColors.kidButton,
                fontFamily: 'TT Norms',
              ),
            ),
            Text(
              endTime,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: AppColors.kidButton,
                fontFamily: 'TT Norms',
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Container(
          width: 2,
          height: 30,
          color: AppColors.kidButton,
          margin: const EdgeInsets.only(top: 2),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${lesson.subject?.title ?? 'Занятие'} ($teacherName)',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: AppColors.kidButton,
                  fontFamily: 'TT Norms',
                ),
              ),
              Text(
                lesson.classroom?.title ?? 'Аудитория',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kidButton,
                  fontFamily: 'TT Norms',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Виджет для заголовка месяца (аналог CalendarHeader)
  Widget _buildMonthHeader() {
    return Container(
      width: 327,
      height: 38,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.kidButton,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => _changeMonth(-1),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 18,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Text(
            _getMonthYearText(_currentDate),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'TT Norms',
            ),
          ),
          IconButton(
            onPressed: () => _changeMonth(1),
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
    );
  }

  Widget _buildCalendarGrid() {
    final days = CalendarUtils.generateMonthDays(_currentDate);

    return GridView.count(
      crossAxisCount: 7,
      childAspectRatio: 1,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: days.map((date) {
        if (date == null) {
          return const SizedBox.shrink();
        }

        final dateKey = CalendarUtils.formatDateKey(date);
        final hasEvent = _events.containsKey(dateKey);
        final isSelected =
            _selectedDate != null &&
            CalendarUtils.isSameDay(_selectedDate, date);

        return GestureDetector(
          onTap: () {
            setState(() => _selectedDate = date);
            _showLessonsPanel(date);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.kidCalendarBlue
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  date.day.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'TT Norms',
                    color: Colors.white,
                  ),
                ),
                if (hasEvent)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : AppColors.kidButton,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SchedulesBloc, ScheduleState>(
      listener: (context, state) {
        if (state is LessonsLoaded) {
          _processLessons(
            state.lessons
                .map(
                  (lesson) => LessonEntity(
                    id: lesson.id,
                    title: lesson.title,
                    startTime: lesson.startTime,
                    endTime: lesson.endTime,
                    date: lesson.date,
                    weekDay: lesson.weekDay,
                    isCanceled: lesson.isCanceled,
                    isCompleted: lesson.isCompleted,
                    duration: lesson.duration,
                    comment: lesson.comment,
                    teacher: lesson.teacher,
                    classroom: lesson.classroom,
                    group: lesson.group,
                    subject: lesson.subject,
                  ),
                )
                .toList(),
          );
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.kidPrimary,
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/images/kid_calendar_icon.png',
                width: 24,
                height: 24,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 24,
                  );
                },
              ),
              const SizedBox(width: 8),
              const Text(
                'Календарь',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'TT Norms',
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.white, Colors.white.withAlpha(0)],
                    stops: const [0.1, 0.5],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/images/background_raiting.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
            Column(
              children: [
                _buildMonthHeader(),
                const SizedBox(height: 10),
                // Дни недели
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _WeekDayText('ПН'),
                      _WeekDayText('ВТ'),
                      _WeekDayText('СР'),
                      _WeekDayText('ЧТ'),
                      _WeekDayText('ПТ'),
                      _WeekDayText('СБ'),
                      _WeekDayText('ВС'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Календарь
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
          ],
        ),
      ),
    );
  }
}

class _WeekDayText extends StatelessWidget {
  final String text;
  const _WeekDayText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'TT Norms',
      ),
    );
  }
}
