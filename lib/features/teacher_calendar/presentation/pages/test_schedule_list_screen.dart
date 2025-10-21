import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_response_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_update_model.dart';
import 'package:treemov/features/teacher_calendar/presentation/blocs/schedules/schedules_bloc.dart';
import 'package:treemov/features/teacher_calendar/presentation/blocs/schedules/schedules_event.dart';
import 'package:treemov/features/teacher_calendar/presentation/blocs/schedules/schedules_state.dart';
import 'package:treemov/features/teacher_calendar/presentation/pages/test_schedule_update_screen.dart';
import 'package:treemov/features/teacher_calendar/presentation/widgets/schedule_detail_screen.dart';

class TestScheduleScreen extends StatelessWidget {
  const TestScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SchedulesBloc>()..add(LoadSchedulesEvent()),
      child: const _TestScheduleView(),
    );
  }
}

class _TestScheduleView extends StatelessWidget {
  const _TestScheduleView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Расписание занятий'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<SchedulesBloc>().add(LoadSchedulesEvent());
            },
          ),
        ],
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
          }
        },
        child: BlocBuilder<SchedulesBloc, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ScheduleError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SchedulesBloc>().add(LoadSchedulesEvent());
                      },
                      child: const Text('Попробовать снова'),
                    ),
                  ],
                ),
              );
            }

            if (state is SchedulesLoaded) {
              final schedules = state.schedules;

              if (schedules.isEmpty) {
                return const Center(
                  child: Text('Нет занятий', style: TextStyle(fontSize: 18)),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<SchedulesBloc>().add(LoadSchedulesEvent());
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: schedules.length,
                  itemBuilder: (context, index) {
                    final schedule = schedules[index];
                    return _ScheduleCard(schedule: schedule);
                  },
                ),
              );
            }

            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<SchedulesBloc>().add(LoadSchedulesEvent());
                },
                child: const Text('Загрузить расписание'),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  final ScheduleResponseModel schedule;

  const _ScheduleCard({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: ListTile(
        leading: _buildStatusIcon(),
        title: Text(
          schedule.title.isEmpty ? '(Без названия)' : schedule.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: schedule.isCanceled ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📅 ${schedule.formattedDate}'),
            if (schedule.formattedTimeRange.isNotEmpty)
              Text('⏰ ${schedule.formattedTimeRange}'),
            if (schedule.formattedEmployer.isNotEmpty)
              Text('👨‍🏫 ${schedule.formattedEmployer}'),
            if (schedule.groupName.isNotEmpty) Text('👥 ${schedule.groupName}'),
            if (schedule.classroomTitle.isNotEmpty)
              Text('🏫 ${schedule.classroomTitle}'),
            if (schedule.isCanceled)
              const Text('❌ Отменено', style: TextStyle(color: Colors.red)),
            if (schedule.isCompleted)
              const Text('✅ Завершено', style: TextStyle(color: Colors.green)),
          ],
        ),
        isThreeLine: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScheduleDetailScreen(schedule: schedule),
            ),
          );
        },
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleMenuAction(context, value),
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: 8),
                  Text('Редактировать'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'cancel',
              child: Row(
                children: [
                  Icon(Icons.cancel, size: 20),
                  SizedBox(width: 8),
                  Text('Отменить занятие'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'complete',
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 20),
                  SizedBox(width: 8),
                  Text('Завершить занятие'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'details',
              child: Row(
                children: [
                  Icon(Icons.info, size: 20),
                  SizedBox(width: 8),
                  Text('Подробнее'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    if (schedule.isCanceled) {
      return const Icon(Icons.cancel, color: Colors.red, size: 30);
    } else if (schedule.isCompleted) {
      return const Icon(Icons.check_circle, color: Colors.green, size: 30);
    } else {
      return const Icon(Icons.schedule, color: Colors.blue, size: 30);
    }
  }

  Future<void> _handleMenuAction(BuildContext context, String action) async {
    final schedulesBloc = context.read<SchedulesBloc>(); // Получаем BLoC

    switch (action) {
      case 'edit':
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScheduleUpdateScreen(
              scheduleId: schedule.id,
              schedulesBloc: schedulesBloc,
            ),
          ),
        );

        // Если вернулись с результатом true - обновляем список
        if (result == true) {
          schedulesBloc.add(LoadSchedulesEvent());
        }
        break;
      case 'cancel':
        _toggleCancelStatus(context, schedulesBloc);
        break;
      case 'complete':
        _toggleCompleteStatus(context, schedulesBloc);
        break;
      case 'details':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScheduleDetailScreen(schedule: schedule),
          ),
        );
        break;
    }
  }

  void _toggleCancelStatus(BuildContext context, SchedulesBloc schedulesBloc) {
    final updateData = ScheduleUpdateModel(isCanceled: !schedule.isCanceled);

    schedulesBloc.add(
      UpdateScheduleEvent(scheduleId: schedule.id, updateData: updateData),
    );
  }

  void _toggleCompleteStatus(
    BuildContext context,
    SchedulesBloc schedulesBloc,
  ) {
    final updateData = ScheduleUpdateModel(isCompleted: !schedule.isCompleted);

    schedulesBloc.add(
      UpdateScheduleEvent(scheduleId: schedule.id, updateData: updateData),
    );
  }
}
