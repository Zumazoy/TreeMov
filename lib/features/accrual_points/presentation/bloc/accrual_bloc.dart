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
    on<LoadTeacherProfileId>(_onLoadTeacherProfileId);
    on<CreateAccrual>(_onCreateAccrual);
  }

  Future<void> _onLoadStudentGroups(
    LoadStudentGroups event,
    Emitter<AccrualState> emit,
  ) async {
    emit(AccrualLoading());
    try {
      final groups = await _sharedRepository.getGroupStudents();
      emit(GroupsLoaded(groups));
    } catch (e) {
      emit(AccrualError(e.toString()));
    }
  }

  Future<void> _onLoadTeacherProfileId(
    LoadTeacherProfileId event,
    Emitter<AccrualState> emit,
  ) async {
    emit(AccrualLoading());
    try {
      final teacherProfile = await _sharedRepository.getMyOrgProfile();

      final teacherProfileId = teacherProfile.baseData.id;

      if (teacherProfileId != null) {
        _teacherProfileId = teacherProfileId;
        emit(TeacherProfileIdLoaded(teacherProfileId));
      } else {
        emit(AccrualError('Не удалось получить ID профиля учителя'));
      }
    } catch (e) {
      emit(AccrualError('Ошибка загрузки профиля учителя: $e'));
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
      add(LoadStudentGroups());
    } catch (e) {
      emit(AccrualError('Ошибка создания начисления: $e'));
    }
  }

  int? get teacherProfileId => _teacherProfileId;
}
