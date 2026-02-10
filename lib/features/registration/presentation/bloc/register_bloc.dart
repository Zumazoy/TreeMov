import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:treemov/features/registration/data/models/register_request_model.dart';
import 'package:treemov/features/registration/domain/repositories/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository _registerRepository;

  RegisterBloc(this._registerRepository) : super(RegisterInitial()) {
    on<RegisterKid>(_onRegisterKid);
    on<RegisterTeacher>(_onRegisterTeacher);
  }

  Future<void> _onRegisterKid(
    RegisterKid event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final request = RegisterRequestModel(
        username: event.username,
        email: event.email,
        password: event.password,
        orgId: null,
      );

      await _registerRepository.register(request);
      emit(RegisterSuccess('Регистрация успешно завершена'));
    } catch (e) {
      emit(RegisterError('Ошибка регистрации ребенка: $e'));
    }
  }

  Future<void> _onRegisterTeacher(
    RegisterTeacher event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final request = RegisterRequestModel(
        username: event.username,
        email: event.email,
        password: event.password,
        orgId: null,
      );

      await _registerRepository.register(request);
      emit(RegisterSuccess('Регистрация успешно завершена'));
    } catch (e) {
      emit(RegisterError('Ошибка регистрации учителя: $e'));
    }
  }
}
