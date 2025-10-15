import 'package:bloc/bloc.dart';

import '../../api/services/schedule_service.dart';
import 'schedules_event.dart';
import 'schedules_state.dart';

class SchedulesBloc extends Bloc<SchedulesEvent, SchedulesState> {
  final ScheduleService service;

  SchedulesBloc({required this.service}) : super(SchedulesInitial()) {
    on<SchedulesRequested>(_onRequested);
  }

  Future<void> _onRequested(
    SchedulesRequested ev,
    Emitter<SchedulesState> emit,
  ) async {
    emit(SchedulesLoadInProgress());
    try {
      final list = await service.fetchSchedules(token: ev.token);
      emit(SchedulesLoadSuccess(list));
    } catch (e) {
      emit(SchedulesLoadFailure(e.toString()));
    }
  }
}
