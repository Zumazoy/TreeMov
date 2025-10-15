import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/api/core/dio_client.dart';
import 'package:treemov/api/services/schedule_service.dart';
import 'package:treemov/bloc/providers.dart';
import 'package:treemov/bloc/schedules/schedules_bloc.dart';
import 'package:treemov/bloc/schedules/schedules_event.dart';
import 'package:treemov/bloc/schedules/schedules_state.dart';

class TestScheduleScreen extends StatelessWidget {
  final String? token;
  const TestScheduleScreen({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // create service using existing DioClient from getIt
    final dioClient = getIt<DioClient>();
    final service = ScheduleService(dioClient);

    return BlocProvider(
      create: (_) =>
          SchedulesBloc(service: service)
            ..add(SchedulesRequested(token: token)),
      child: const _TestScheduleView(),
    );
  }
}

class _TestScheduleView extends StatelessWidget {
  const _TestScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Тест — Занятия')),
      body: RefreshIndicator(
        onRefresh: () async {
          final bloc = context.read<SchedulesBloc>();
          bloc.add(SchedulesRequested());
        },
        child: BlocBuilder<SchedulesBloc, SchedulesState>(
          builder: (context, state) {
            if (state is SchedulesInitial || state is SchedulesLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SchedulesLoadFailure) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Ошибка: ${state.error}'),
                  ),
                ],
              );
            } else if (state is SchedulesLoadSuccess) {
              final items = state.schedules;
              if (items.isEmpty) {
                return ListView(
                  children: const [
                    SizedBox(height: 80),
                    Center(child: Text('Занятий не найдено')),
                  ],
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final s = items[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 4,
                    ),
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (s.isCanceled)
                            const Icon(Icons.cancel)
                          else if (s.isCompleted)
                            const Icon(Icons.check_circle)
                          else
                            const Icon(Icons.schedule),
                        ],
                      ),
                      title: Text(s.title.isEmpty ? '(Без названия)' : s.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (s.date != null) Text('Дата: ${s.date}'),
                          if ((s.startTime ?? '').isNotEmpty ||
                              (s.endTime ?? '').isNotEmpty)
                            Text('Время: ${_formatTimeRange(s)}'),
                          if (s.teacher.isNotEmpty)
                            Text('Преподаватель: ${s.teacher}'),
                          if (s.groupName.isNotEmpty)
                            Text('Группа: ${s.groupName}'),
                          if (s.classroom.isNotEmpty)
                            Text('Аудитория: ${s.classroom}'),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  String _formatTimeRange(dynamic s) {
    String start = '';
    String end = '';
    try {
      start = s.startTime != null
          ? (s.startTime as String).substring(0, 5)
          : '';
      end = s.endTime != null ? (s.endTime as String).substring(0, 5) : '';
    } catch (_) {}
    return [start, end].where((x) => x.isNotEmpty).join(' — ');
  }
}
