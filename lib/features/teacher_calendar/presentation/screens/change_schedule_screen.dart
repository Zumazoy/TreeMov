import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';

class EditEventScreen extends StatefulWidget {
  final String eventId;
  final String initialGroup;
  final String initialLessonType;
  final String initialLocation;
  final DateTime initialStartDateTime;
  final DateTime initialEndDateTime;
  final String initialRepeat;
  final String initialReminder;
  final String initialDescription;

  const EditEventScreen({
    super.key,
    required this.eventId,
    required this.initialGroup,
    required this.initialLessonType,
    required this.initialLocation,
    required this.initialStartDateTime,
    required this.initialEndDateTime,
    required this.initialRepeat,
    required this.initialReminder,
    required this.initialDescription,
  });

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  String? _selectedGroup;
  String? _selectedLessonType;
  String? _selectedLocation;
  String? _selectedRepeat;
  String? _selectedReminder;
  final TextEditingController _descriptionController = TextEditingController();

  // демонстрационные данные
  final List<String> _groupOptions = ['Группа 1', 'Группа 2', 'Группа 3'];
  final List<String> _lessonTypeOptions = [
    'Растяжка',
    'Йога',
    'Фитнес',
    'Силовая тренировка',
  ];
  final List<String> _locationOptions = [
    'Тренажерный зал',
    'Большой зал',
    'Малый зал',
  ];
  final List<String> _repeatOptions = [
    'Не повторять',
    'Ежедневно',
    'Еженедельно',
    'Ежемесячно',
    'Через 2 дня',
    'Через 3 дня',
  ];
  final List<String> _reminderOptions = [
    'Не напоминать',
    'За 5 минут',
    'За 15 минут',
    'За 30 минут',
    'За 1 час',
  ];

  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now().add(const Duration(hours: 1));

  @override
  void initState() {
    super.initState();
    // Инициализация данными из переданного события
    _selectedGroup = widget.initialGroup;
    _selectedLessonType = widget.initialLessonType;
    _selectedLocation = widget.initialLocation;
    _startDateTime = widget.initialStartDateTime;
    _endDateTime = widget.initialEndDateTime;
    _selectedRepeat = widget.initialRepeat;
    _selectedReminder = widget.initialReminder;
    _descriptionController.text = widget.initialDescription;
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
          if (_endDateTime.isBefore(_startDateTime)) {
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

  void _updateEvent() {
    //
    // context.read<EventBloc>().add(UpdateEvent(
    //   eventId: widget.eventId,
    //   group: _selectedGroup!,
    //   lessonType: _selectedLessonType!,
    //   location: _selectedLocation!,
    //   startDateTime: _startDateTime,
    //   endDateTime: _endDateTime,
    //   repeat: _selectedRepeat,
    //   reminder: _selectedReminder,
    //   description: _descriptionController.text,
    // ));

    // Временно возвращаем назад
    Navigator.pop(context);
  }

  Widget _buildDropdownCard({
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
        hintText: title,
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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.teacherPrimary,
        automaticallyImplyLeading: false,
        title: const Text(
          'Изменить событие',
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
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: _updateEvent,
          ),
        ],
      ),
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
                      _buildDropdownCard(
                        title: 'Группа/ученик',
                        value: _selectedGroup,
                        options: _groupOptions,
                        onSelected: (value) {
                          setState(() {
                            _selectedGroup = value;
                          });
                        },
                        iconPath: 'assets/images/group_icon.png',
                      ),
                      const SizedBox(height: 8),

                      _buildDropdownCard(
                        title: 'Вид занятия',
                        value: _selectedLessonType,
                        options: _lessonTypeOptions,
                        onSelected: (value) {
                          setState(() {
                            _selectedLessonType = value;
                          });
                        },
                        iconPath: 'assets/images/activity_icon.png',
                      ),
                      const SizedBox(height: 8),

                      _buildDropdownCard(
                        title: 'Локация',
                        value: _selectedLocation,
                        options: _locationOptions,
                        onSelected: (value) {
                          setState(() {
                            _selectedLocation = value;
                          });
                        },
                        iconPath: 'assets/images/place_icon.png',
                      ),
                      const SizedBox(height: 8),

                      _buildDateTimeSection(),
                      const SizedBox(height: 8),

                      _buildDropdownCard(
                        title: 'Повтор',
                        value: _selectedRepeat,
                        options: _repeatOptions,
                        onSelected: (value) {
                          setState(() {
                            _selectedRepeat = value;
                          });
                        },
                        iconPath: 'assets/images/repeat_icon.png',
                      ),
                      const SizedBox(height: 8),

                      _buildDropdownCard(
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
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
