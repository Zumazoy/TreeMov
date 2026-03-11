import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:treemov/features/accrual_points/data/models/accrual_request_model.dart';
import 'package:treemov/features/accrual_points/domain/repositories/accrual_repository.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

part 'accrual_event.dart';
part 'accrual_state.dart';

class AccrualBloc extends Bloc<AccrualEvent, AccrualState> {
  final SharedRepository _sharedRepository;
  final AccrualRepository _accrualRepository;

  int? _teacherProfileId;

  AccrualBloc(this._sharedRepository, this._accrualRepository)
    : super(AccrualInitial()) {
    on<LoadStudentGroups>(_onLoadStudentGroups);
    on<CreateAccrual>(_onCreateAccrual);
  }

  Future<void> _onLoadStudentGroups(
    LoadStudentGroups event,
    Emitter<AccrualState> emit,
  ) async {
    emit(AccrualLoading());
    try {
      // Сначала загружаем группы
      final groups = await _sharedRepository.getGroupStudents();

      // Затем для каждой группы загружаем учеников
      final Map<int, int> groupStudentCounts = {};
      final Map<int, List<dynamic>> groupStudents = {};

      for (var group in groups) {
        if (group.baseData.id != null) {
          try {
            final students = await _sharedRepository.getStudentsInGroup(
              group.baseData.id!,
            );
            groupStudentCounts[group.baseData.id!] = students.length;
            groupStudents[group.baseData.id!] = students;
          } catch (e) {
            groupStudentCounts[group.baseData.id!] = 0;
            groupStudents[group.baseData.id!] = [];
          }
        }
      }

      emit(
        GroupsLoaded(
          groups: groups,
          groupStudentCounts: groupStudentCounts,
          groupStudents: groupStudents,
        ),
      );
    } catch (e) {
      emit(AccrualError(e.toString()));
    }
  }

  Future<void> _onCreateAccrual(
    CreateAccrual event,
    Emitter<AccrualState> emit,
  ) async {
    emit(AccrualCreating());
    try {
      await _accrualRepository.createAccrual(event.request);
      emit(AccrualCreated('Начисление успешно создано'));

      await Future.delayed(const Duration(milliseconds: 500));

      add(LoadStudentGroups());
    } catch (e) {
      emit(AccrualError('Ошибка создания начисления: $e'));
    }
  }

  int? get teacherProfileId => _teacherProfileId;
}
