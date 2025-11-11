import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_response_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_update_model.dart';
import 'package:treemov/features/teacher_calendar/presentation/blocs/schedules/schedules_bloc.dart';
import 'package:treemov/features/teacher_calendar/presentation/blocs/schedules/schedules_event.dart';
import 'package:treemov/features/teacher_calendar/presentation/blocs/schedules/schedules_state.dart';

class ScheduleUpdateScreen extends StatefulWidget {
  final int scheduleId;
  final SchedulesBloc schedulesBloc;

  const ScheduleUpdateScreen({
    super.key,
    required this.scheduleId,
    required this.schedulesBloc,
  });

  @override
  State<ScheduleUpdateScreen> createState() => _ScheduleUpdateScreenState();
}

class _ScheduleUpdateScreenState extends State<ScheduleUpdateScreen> {
  final _titleController = TextEditingController();
  final _classroomIdController = TextEditingController();
  final _groupIdController = TextEditingController();
  final _teacherIdController = TextEditingController();
  final _subjectIdController = TextEditingController();
  final _lessonController = TextEditingController();
  final _periodScheduleIdController = TextEditingController();

  bool _isInitialLoad = true;
  bool _isCanceled = false;
  bool _isCompleted = false;
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  @override
  void initState() {
    super.initState();
    if (_isInitialLoad) {
      widget.schedulesBloc.add(LoadScheduleByIdEvent(widget.scheduleId));
      _isInitialLoad = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.schedulesBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Редактирование занятия #${widget.scheduleId}'),
        ),
        body: BlocListener<SchedulesBloc, ScheduleState>(
          listener: (context, state) {
            if (state is ScheduleError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }

            if (state is ScheduleOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context, true);
            }

            if (state is ScheduleLoaded) {
              _populateForm(state.schedule);
            }
          },
          child: BlocBuilder<SchedulesBloc, ScheduleState>(
            builder: (context, state) {
              final isLoading = state is ScheduleLoading;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    _buildBasicInfoSection(isLoading),
                    const SizedBox(height: 20),
                    _buildDateTimeSection(isLoading),
                    const SizedBox(height: 20),
                    _buildIdsSection(isLoading),
                    const SizedBox(height: 20),
                    _buildStatusSection(isLoading),
                    const SizedBox(height: 24),
                    _buildActionButton(isLoading),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection(bool isLoading) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Основная информация',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Название занятия',
                border: OutlineInputBorder(),
              ),
              enabled: !isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeSection(bool isLoading) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Дата и время',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Дата занятия'),
              subtitle: Text(
                _selectedDate != null
                    ? '${_selectedDate!.day.toString().padLeft(2, '0')}.${_selectedDate!.month.toString().padLeft(2, '0')}.${_selectedDate!.year}'
                    : 'Не изменено',
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: isLoading ? null : _selectDate,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.access_time, color: Colors.green),
              title: const Text('Время начала'),
              subtitle: Text(
                _startTime != null
                    ? _startTime!.format(context)
                    : 'Не изменено',
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: isLoading ? null : _selectStartTime,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.access_time, color: Colors.red),
              title: const Text('Время окончания'),
              subtitle: Text(
                _endTime != null ? _endTime!.format(context) : 'Не изменено',
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: isLoading ? null : _selectEndTime,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIdsSection(bool isLoading) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Идентификаторы',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildIdField(
                  'ID аудитории',
                  _classroomIdController,
                  Icons.meeting_room,
                ),
                _buildIdField('ID группы', _groupIdController, Icons.group),
                _buildIdField(
                  'ID преподавателя',
                  _teacherIdController,
                  Icons.person,
                ),
                _buildIdField(
                  'ID предмета',
                  _subjectIdController,
                  Icons.menu_book,
                ),
                _buildIdField(
                  'Номер урока',
                  _lessonController,
                  Icons.format_list_numbered,
                ),
                _buildIdField(
                  'ID периодического расписания',
                  _periodScheduleIdController,
                  Icons.repeat,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIdField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildStatusSection(bool isLoading) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Статус',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Отменено:'),
                const SizedBox(width: 8),
                Switch(
                  value: _isCanceled,
                  onChanged: isLoading
                      ? null
                      : (value) {
                          setState(() => _isCanceled = value);
                        },
                ),
                const Spacer(),
                const Text('Завершено:'),
                const SizedBox(width: 8),
                Switch(
                  value: _isCompleted,
                  onChanged: isLoading
                      ? null
                      : (value) {
                          setState(() => _isCompleted = value);
                        },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(bool isLoading) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ElevatedButton(
            onPressed: _updateSchedule,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Обновить занятие'),
          );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? const TimeOfDay(hour: 9, minute: 0),
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
      initialTime: _endTime ?? const TimeOfDay(hour: 10, minute: 0),
    );
    if (picked != null) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  void _populateForm(ScheduleResponseModel schedule) {
    setState(() {
      _titleController.text = schedule.title;
      _isCanceled = schedule.isCanceled;
      _isCompleted = schedule.isCompleted;

      // _classroomIdController.text = schedule.classroomId.toString();
      // _groupIdController.text = schedule.groupId.toString();
      // _teacherIdController.text = schedule.teacherId.toString();
      // _subjectIdController.text = schedule.subjectId.toString();
      if (schedule.lesson != null) {
        _lessonController.text = schedule.lesson.toString();
      }
      if (schedule.periodSchedule != null) {
        _periodScheduleIdController.text = schedule.periodSchedule.toString();
      }

      _selectedDate = DateTime.parse(schedule.date);
      if (schedule.startTime != null) {
        final parts = schedule.startTime!.split(':');
        _startTime = TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
      if (schedule.endTime != null) {
        final parts = schedule.endTime!.split(':');
        _endTime = TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
    });
  }

  void _updateSchedule() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Введите название занятия'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Используем widget.schedulesBloc вместо context.read
    final currentState = widget.schedulesBloc.state;
    ScheduleResponseModel? originalSchedule;

    if (currentState is ScheduleLoaded) {
      originalSchedule = currentState.schedule;
    } else {
      // Если состояние не ScheduleLoaded, можно показать ошибку или использовать альтернативный подход
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ошибка: данные занятия не загружены'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final updateData = ScheduleUpdateModel.withOriginal(
      original: originalSchedule,
      title: _titleController.text.isEmpty ? null : _titleController.text,
      isCanceled: _isCanceled,
      isCompleted: _isCompleted,
      classroomId: _classroomIdController.text.isEmpty
          ? null
          : int.tryParse(_classroomIdController.text),
      groupId: _groupIdController.text.isEmpty
          ? null
          : int.tryParse(_groupIdController.text),
      teacherId: _teacherIdController.text.isEmpty
          ? null
          : int.tryParse(_teacherIdController.text),
      subjectId: _subjectIdController.text.isEmpty
          ? null
          : int.tryParse(_subjectIdController.text),
      lesson: _lessonController.text.isEmpty
          ? null
          : int.tryParse(_lessonController.text),
      periodScheduleId: _periodScheduleIdController.text.isEmpty
          ? null
          : int.tryParse(_periodScheduleIdController.text),
      date: _selectedDate,
      startTime: _startTime,
      endTime: _endTime,
    );

    widget.schedulesBloc.add(
      UpdateScheduleEvent(
        scheduleId: widget.scheduleId,
        updateData: updateData,
      ),
    );

    // Закрываем экран и передаем результат
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _classroomIdController.dispose();
    _groupIdController.dispose();
    _teacherIdController.dispose();
    _subjectIdController.dispose();
    _lessonController.dispose();
    _periodScheduleIdController.dispose();
    super.dispose();
  }
}
