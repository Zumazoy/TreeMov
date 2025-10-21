import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class CreateScheduleScreen extends StatefulWidget {
  const CreateScheduleScreen({super.key});

  @override
  State<CreateScheduleScreen> createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> {
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

  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);

  Future<void> _selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
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
    if (picked != null) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
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
    if (picked != null) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  void _saveEvent() {
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

  Widget _buildSelectionCard(
    String title,
    String? value, {
    bool showArrow = true,
    required String iconPath,
  }) {
    return Container(
      width: 352,
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.eventTap, width: 1),
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 20,
              height: 20,
              color: AppColors.grayFieldText,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value ?? title,
                style: const TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.0,
                  color: AppColors.grayFieldText,
                ),
              ),
            ),
            if (showArrow)
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSection() {
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
                onTap: _selectStartTime,
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
                      _startTime.format(context),
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
                onTap: _selectEndTime,
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
                      _endTime.format(context),
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
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: _saveEvent,
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 26),
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

                    _buildTimeSection(),
                    const SizedBox(height: 8),

                    _buildSelectionCard(
                      'Повтор',
                      _selectedRepeat,
                      showArrow: false,
                      iconPath: 'assets/images/repeat_icon.png',
                    ),
                    const SizedBox(height: 8),

                    _buildSelectionCard(
                      'Добавить напоминание',
                      _selectedReminder,
                      showArrow: false,
                      iconPath: 'assets/images/bell_icon.png',
                    ),
                    const SizedBox(height: 8),

                    _buildDescriptionField(),
                  ],
                ),
              ),
            ],
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
