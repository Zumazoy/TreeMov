import 'package:flutter/material.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/teacher_calendar/data/datasources/schedule_remote_data_source.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_request_model.dart';

class CreateScheduleScreen extends StatefulWidget {
  const CreateScheduleScreen({super.key});

  @override
  State<CreateScheduleScreen> createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  int _classroomId = 1;
  int _groupId = 1;
  int? _periodScheduleId;
  int _teacherId = 1;
  int _subjectId = 1;
  int? _lesson;

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);

  bool _isLoading = false;

  late ScheduleRemoteDataSource _scheduleService;

  @override
  void initState() {
    super.initState();
    _scheduleService = ScheduleRemoteDataSource(getIt<DioClient>());
  }

  Future<void> _createSchedule() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final request = ScheduleRequestModel(
          classroomId: _classroomId,
          groupId: _groupId,
          periodScheduleId: _periodScheduleId,
          teacherId: _teacherId,
          subjectId: _subjectId,
          lesson: _lesson,
          title: _titleController.text,
          date: _selectedDate,
          startTime: _startTime,
          endTime: _endTime,
        );

        await _scheduleService.createSchedule(request);

        // Если метод возвращает ScheduleResponseModel, значит создание успешно
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Занятие успешно создано!'),
              backgroundColor: Colors.green,
            ),
          );
          _clearForm();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ошибка создания: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _clearForm() {
    _titleController.clear();
    _classroomId = 1;
    _groupId = 1;
    _periodScheduleId = null;
    _teacherId = 1;
    _subjectId = 1;
    _lesson = null;
    _selectedDate = DateTime.now();
    _startTime = const TimeOfDay(hour: 9, minute: 0);
    _endTime = const TimeOfDay(hour: 10, minute: 0);
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null) {
      setState(() {
        _startTime = picked;
        // Автоматически устанавливаем конечное время на 1 час позже
        _endTime = TimeOfDay(hour: picked.hour + 1, minute: picked.minute);
      });
    }
  }

  Future<void> _selectEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создание занятия'),
        backgroundColor: const Color(0xFF75D0FF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearForm,
            tooltip: 'Очистить форму',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Заголовок занятия
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Основная информация',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                labelText: 'Название занятия *',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.title),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите название занятия';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Дата и время
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Дата и время',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Выбор даты
                            ListTile(
                              leading: const Icon(
                                Icons.calendar_today,
                                color: Colors.blue,
                              ),
                              title: const Text('Дата занятия'),
                              subtitle: Text(_formatDate(_selectedDate)),
                              trailing: const Icon(Icons.arrow_drop_down),
                              onTap: _selectDate,
                            ),

                            const Divider(),

                            // Выбор времени начала
                            ListTile(
                              leading: const Icon(
                                Icons.access_time,
                                color: Colors.green,
                              ),
                              title: const Text('Время начала'),
                              subtitle: Text(_startTime.format(context)),
                              trailing: const Icon(Icons.arrow_drop_down),
                              onTap: _selectStartTime,
                            ),

                            const Divider(),

                            // Выбор времени окончания
                            ListTile(
                              leading: const Icon(
                                Icons.access_time,
                                color: Colors.red,
                              ),
                              title: const Text('Время окончания'),
                              subtitle: Text(_endTime.format(context)),
                              trailing: const Icon(Icons.arrow_drop_down),
                              onTap: _selectEndTime,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ID объектов
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Идентификаторы',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Grid для ID полей
                            GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                _buildIdField(
                                  'ID аудитории *',
                                  _classroomId.toString(),
                                  Icons.meeting_room,
                                  (value) =>
                                      _classroomId = int.tryParse(value) ?? 1,
                                ),
                                _buildIdField(
                                  'ID группы *',
                                  _groupId.toString(),
                                  Icons.group,
                                  (value) =>
                                      _groupId = int.tryParse(value) ?? 1,
                                ),
                                _buildIdField(
                                  'ID преподавателя *',
                                  _teacherId.toString(),
                                  Icons.person,
                                  (value) =>
                                      _teacherId = int.tryParse(value) ?? 1,
                                ),
                                _buildIdField(
                                  'ID предмета *',
                                  _subjectId.toString(),
                                  Icons.menu_book,
                                  (value) =>
                                      _subjectId = int.tryParse(value) ?? 1,
                                ),
                                _buildIdField(
                                  'ID периодического расписания',
                                  _periodScheduleId?.toString() ?? '',
                                  Icons.repeat,
                                  (value) => _periodScheduleId = value.isEmpty
                                      ? null
                                      : int.tryParse(value),
                                  optional: true,
                                ),
                                _buildIdField(
                                  'Номер урока',
                                  _lesson?.toString() ?? '',
                                  Icons.format_list_numbered,
                                  (value) => _lesson = value.isEmpty
                                      ? null
                                      : int.tryParse(value),
                                  optional: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Кнопки действий
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _clearForm,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: const BorderSide(color: Colors.grey),
                            ),
                            child: const Text(
                              'Очистить',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _createSchedule,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF75D0FF),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Создать занятие',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Информация о продолжительности
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Продолжительность: ${_calculateDuration().inMinutes} минут',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildIdField(
    String label,
    String initialValue,
    IconData icon,
    Function(String) onChanged, {
    bool optional = false,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
        suffixIcon: optional
            ? null
            : const Icon(Icons.star, color: Colors.red, size: 12),
      ),
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      validator: optional
          ? null
          : (value) {
              if (value == null || value.isEmpty) {
                return 'Обязательное поле';
              }
              if (int.tryParse(value) == null) {
                return 'Введите число';
              }
              return null;
            },
    );
  }

  Duration _calculateDuration() {
    final start = DateTime(2024, 1, 1, _startTime.hour, _startTime.minute);
    final end = DateTime(2024, 1, 1, _endTime.hour, _endTime.minute);
    return end.difference(start);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
