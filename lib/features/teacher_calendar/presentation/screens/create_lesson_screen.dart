import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/features/teacher_calendar/data/models/lesson_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_lesson_request_model.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_bloc.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_event.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_state.dart';
import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

import '../../../../core/themes/app_colors.dart';

class CreateLessonScreen extends StatefulWidget {
  final SharedRepository sharedRepository;
  final SchedulesBloc schedulesBloc;

  const CreateLessonScreen({
    super.key,
    required this.sharedRepository,
    required this.schedulesBloc,
  });

  @override
  State<CreateLessonScreen> createState() => _CreateLessonScreenState();
}

class _CreateLessonScreenState extends State<CreateLessonScreen> {
  int? _classroomId;
  int? _groupId;
  int? _teacherId;
  int? _subjectId;

  String? _selectedGroupName;
  String? _selectedSubjectName;
  String? _selectedClassroomName;
  String? _selectedRepeatOption;
  String? _selectedReminder;

  final TextEditingController _descriptionController = TextEditingController();

  List<StudentGroupResponseModel> _groups = [];
  List<SubjectResponseModel> _subjects = [];
  List<ClassroomResponseModel> _classrooms = [];

  bool _isLoading = true;
  String? _error;

  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now().add(const Duration(hours: 1));

  final List<String> _repeatOptions = ['Повтор', 'Ежедневно', 'Еженедельно'];

  final List<String> _reminderOptions = [
    'Не напоминать',
    'За 5 минут',
    'За 15 минут',
    'За 30 минут',
    'За 1 час',
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      final results = await Future.wait([
        widget.sharedRepository.getStudentGroups(),
        widget.sharedRepository.getSubjects(),
        widget.sharedRepository.getClassrooms(),
        widget.sharedRepository.getTeacherId(),
      ]);

      setState(() {
        _groups = results[0] as List<StudentGroupResponseModel>;
        _subjects = results[1] as List<SubjectResponseModel>;
        _classrooms = results[2] as List<ClassroomResponseModel>;
        _teacherId = results[3] as int?;

        // Устанавливаем значения по умолчанию
        if (_groups.isNotEmpty) {
          _groupId = _groups.first.id;
          _selectedGroupName = _groups.first.name ?? 'Без названия';
        }

        if (_subjects.isNotEmpty) {
          _subjectId = _subjects.first.id;
          _selectedSubjectName = _subjects.first.name ?? 'Без названия';
        }

        if (_classrooms.isNotEmpty) {
          _classroomId = _classrooms.first.id;
          _selectedClassroomName = _classrooms.first.title ?? 'Без названия';
        }

        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Ошибка загрузки данных: $e';
      });
    }
  }

  void _createLesson() {
    if (_isLoading) return;

    if (_groupId == null || _subjectId == null || _classroomId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пожалуйста, выберите группу, предмет и аудиторию'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_teacherId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не удалось определить преподавателя'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final String lessonTitle =
        '${_selectedSubjectName ?? 'Занятие'} (${_selectedGroupName != null ? 'Группа "$_selectedGroupName"' : 'Группа'})';

    if (_selectedRepeatOption == 'Повтор' || _selectedRepeatOption == null) {
      // Обычное событие без повторения
      final request = LessonRequestModel(
        teacherId: _teacherId!,
        subjectId: _subjectId!,
        groupId: _groupId!,
        classroomId: _classroomId!,
        title: lessonTitle,
        startTime: TimeOfDay.fromDateTime(_startDateTime),
        endTime: TimeOfDay.fromDateTime(_endDateTime),
        date: _startDateTime,
        comment: _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : '',
      );

      widget.schedulesBloc.add(CreateLessonEvent(request));
    } else {
      // Периодическое событие
      final period = _getPeriodValue(_selectedRepeatOption!);
      final repeatUntilDate = _calculateRepeatUntilDate();

      final request = PeriodLessonRequestModel(
        teacherId: _teacherId!,
        subjectId: _subjectId!,
        groupId: _groupId!,
        classroomId: _classroomId!,
        title: lessonTitle,
        startTime: TimeOfDay.fromDateTime(_startDateTime),
        endTime: TimeOfDay.fromDateTime(_endDateTime),
        period: period,
        repeatUntilDate: repeatUntilDate,
        startDate: _startDateTime,
      );

      widget.schedulesBloc.add(CreatePeriodLessonEvent(request));
    }
  }

  int _getPeriodValue(String repeatOption) {
    switch (repeatOption) {
      case 'Ежедневно':
        return 1;
      case 'Еженедельно':
        return 7;
      default:
        return 0;
    }
  }

  DateTime _calculateRepeatUntilDate() {
    // Устанавливаем повторение на 1 месяц вперед
    return _startDateTime.add(const Duration(days: 30));
  }

  String _formatDateTime(DateTime dateTime) {
    return '${_formatDate(dateTime)} ${_formatTime(dateTime)}';
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year}';
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _selectStartDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.teacherPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_startDateTime),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.teacherPrimary,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null && mounted) {
        setState(() {
          _startDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          if (_startDateTime.isAfter(_endDateTime)) {
            _endDateTime = _startDateTime.add(const Duration(hours: 1));
          }
        });
      }
    }
  }

  Future<void> _selectEndDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _endDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.teacherPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_endDateTime),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.teacherPrimary,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null && mounted) {
        setState(() {
          _endDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Widget _buildRepeatDropdown() {
    return _buildStringDropdownCard(
      title: 'Повтор',
      value: _selectedRepeatOption ?? 'Повтор',
      options: _repeatOptions,
      onSelected: (value) {
        setState(() {
          _selectedRepeatOption = value;
        });
      },
      iconPath: 'assets/images/repeat_icon.png',
    );
  }

  Widget _buildModelDropdownCard<T>({
    required String title,
    required String? displayValue,
    required List<T> items,
    required String Function(T) getDisplayName,
    required int? Function(T) getId,
    required Function(T?) onSelected,
    required String iconPath,
  }) {
    return Container(
      width: 352,
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.eventTap, width: 1),
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: DropdownMenu<T>(
        initialSelection: items.isNotEmpty ? items.first : null,
        onSelected: onSelected,
        dropdownMenuEntries: items
            .map(
              (item) => DropdownMenuEntry<T>(
                value: item,
                label: getDisplayName(item),
              ),
            )
            .toList(),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Arial',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.0,
          color: AppColors.grayFieldText,
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          elevation: WidgetStateProperty.all(2),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
          ),
        ),
        width: 352,
        hintText: displayValue ?? title,
        leadingIcon: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Image.asset(
            iconPath,
            width: 20,
            height: 20,
            color: AppColors.grayFieldText,
          ),
        ),
        trailingIcon: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(
            Icons.expand_more,
            size: 20,
            color: AppColors.grayFieldText,
          ),
        ),
      ),
    );
  }

  // Обновленный метод для обычных выпадающих списков
  Widget _buildStringDropdownCard({
    required String title,
    required String? value,
    required List<String> options,
    required Function(String?) onSelected,
    required String iconPath,
  }) {
    return Container(
      width: 352,
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.eventTap, width: 1),
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: DropdownMenu<String>(
        initialSelection: value,
        onSelected: onSelected,
        dropdownMenuEntries: options
            .map(
              (option) =>
                  DropdownMenuEntry<String>(value: option, label: option),
            )
            .toList(),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Arial',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.0,
          color: AppColors.grayFieldText,
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          elevation: WidgetStateProperty.all(2),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
          ),
        ),
        width: 352,
        hintText: value ?? title,
        leadingIcon: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Image.asset(
            iconPath,
            width: 20,
            height: 20,
            color: AppColors.grayFieldText,
          ),
        ),
        trailingIcon: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(
            Icons.expand_more,
            size: 20,
            color: AppColors.grayFieldText,
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeSection() {
    return Container(
      width: 352,
      height: 90,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.eventTap, width: 1),
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _selectStartDateTime,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/clock_icon.png',
                      width: 20,
                      height: 20,
                      color: AppColors.grayFieldText,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Начало:',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.0,
                        color: AppColors.grayFieldText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDateTime(_startDateTime),
                      style: const TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.0,
                        color: AppColors.grayFieldText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 1, color: AppColors.eventTap),

            Expanded(
              child: GestureDetector(
                onTap: _selectEndDateTime,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const SizedBox(width: 12),
                    const Text(
                      'Конец:',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.0,
                        color: AppColors.grayFieldText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDateTime(_endDateTime),
                      style: const TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.0,
                        color: AppColors.grayFieldText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      width: 352,
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.eventTap, width: 1),
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Image.asset(
              'assets/images/desc_icon.png',
              width: 20,
              height: 20,
              color: AppColors.grayFieldText,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Описание',
                  hintStyle: TextStyle(
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.0,
                    color: AppColors.grayFieldText,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.0,
                  color: AppColors.grayFieldText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildScaffold(
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return _buildScaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loadInitialData,
                child: const Text('Повторить'),
              ),
            ],
          ),
        ),
      );
    }

    return BlocListener<SchedulesBloc, ScheduleState>(
      bloc: widget.schedulesBloc,
      listener: (context, state) {
        if (state is LessonOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        }

        if (state is LessonError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: _buildScaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 26),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 352,
                    child: Column(
                      children: [
                        // Группа
                        _buildModelDropdownCard<StudentGroupResponseModel>(
                          title: 'Группа/ученик',
                          displayValue: _selectedGroupName,
                          items: _groups,
                          getDisplayName: (group) =>
                              group.name ?? 'Без названия',
                          getId: (group) => group.id,
                          onSelected: (group) {
                            if (group != null) {
                              setState(() {
                                _groupId = group.id;
                                _selectedGroupName =
                                    group.name ?? 'Без названия';
                              });
                            }
                          },
                          iconPath: 'assets/images/group_icon.png',
                        ),
                        const SizedBox(height: 8),

                        // Предмет (вид занятия)
                        _buildModelDropdownCard<SubjectResponseModel>(
                          title: 'Вид занятия',
                          displayValue: _selectedSubjectName,
                          items: _subjects,
                          getDisplayName: (subject) =>
                              subject.name ?? 'Без названия',
                          getId: (subject) => subject.id,
                          onSelected: (subject) {
                            if (subject != null) {
                              setState(() {
                                _subjectId = subject.id;
                                _selectedSubjectName =
                                    subject.name ?? 'Без названия';
                              });
                            }
                          },
                          iconPath: 'assets/images/activity_icon.png',
                        ),
                        const SizedBox(height: 8),

                        // Аудитория (локация)
                        _buildModelDropdownCard<ClassroomResponseModel>(
                          title: 'Локация',
                          displayValue: _selectedClassroomName,
                          items: _classrooms,
                          getDisplayName: (classroom) =>
                              classroom.title ?? 'Без названия',
                          getId: (classroom) => classroom.id,
                          onSelected: (classroom) {
                            if (classroom != null) {
                              setState(() {
                                _classroomId = classroom.id;
                                _selectedClassroomName =
                                    classroom.title ?? 'Без названия';
                              });
                            }
                          },
                          iconPath: 'assets/images/place_icon.png',
                        ),
                        const SizedBox(height: 8),

                        // Период расписания (повтор)
                        _buildRepeatDropdown(),
                        const SizedBox(height: 8),

                        _buildDateTimeSection(),
                        const SizedBox(height: 8),

                        _buildStringDropdownCard(
                          title: 'Добавить напоминание',
                          value: _selectedReminder,
                          options: _reminderOptions,
                          onSelected: (value) {
                            setState(() {
                              _selectedReminder = value;
                            });
                          },
                          iconPath: 'assets/images/bell_icon.png',
                        ),
                        const SizedBox(height: 8),

                        _buildDescriptionField(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScaffold({required Widget body}) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.teacherPrimary,
        automaticallyImplyLeading: false,
        title: const Text(
          'Новое событие',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            height: 1.0,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (!_isLoading && _error == null)
            IconButton(
              icon: const Icon(Icons.check, color: Colors.white),
              onPressed: _createLesson,
            ),
        ],
      ),
      body: body,
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
