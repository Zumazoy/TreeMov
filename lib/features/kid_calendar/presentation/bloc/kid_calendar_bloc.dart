import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/features/kid_calendar/domain/usecases/kid_calendar_usecase.dart';

import 'kid_calendar_event.dart';
import 'kid_calendar_state.dart';

class KidCalendarBloc extends Bloc<KidCalendarEvent, KidCalendarState> {
  final GetKidCalendarUseCase getKidCalendar;

  KidCalendarBloc({required this.getKidCalendar})
    : super(const KidCalendarState()) {
    on<LoadKidCalendar>(_onLoad);
    on<SelectKidDay>(_onSelectDay);
  }

  Future<void> _onLoad(
    LoadKidCalendar event,
    Emitter<KidCalendarState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final events = await getKidCalendar.call(kidId: event.kidId);
      final lessonDays = events.map((e) => e.day).toSet();
      final selected = events.isNotEmpty ? events.first.day : null;
      emit(
        state.copyWith(
          isLoading: false,
          events: events,
          lessonDays: lessonDays,
          selectedDay: selected,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onSelectDay(SelectKidDay event, Emitter<KidCalendarState> emit) {
    emit(state.copyWith(selectedDay: event.day));
  }
}
