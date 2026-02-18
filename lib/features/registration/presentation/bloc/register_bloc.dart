import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/register_repository.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository repository;

  String? _email;

  RegisterBloc({required this.repository}) : super(RegisterInitial()) {
    on<SubmitRegistrationEvent>(_onRegister);
    on<SubmitVerificationCodeEvent>(_onVerify);
    on<ResendCodeEvent>(_onResend);
  }

  Future<void> _onRegister(
    SubmitRegistrationEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      _email = event.email;

      await repository.registerUser(
        username: event.username,
        email: event.email,
        password: event.password,
      );

      emit(RegisterCodeSent(email: event.email));
    } catch (e) {
      emit(RegisterFailure("Ошибка регистрации: ${e.toString()}"));
    }
  }

  Future<void> _onVerify(
    SubmitVerificationCodeEvent event,
    Emitter<RegisterState> emit,
  ) async {
    if (_email == null) {
      emit(RegisterFailure("Ошибка сессии. Перезапустите регистрацию."));
      return;
    }

    emit(RegisterLoading());
    try {
      await repository.verifyEmailOnly(email: _email!, code: event.code);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure("Ошибка верификации: ${e.toString()}"));
      emit(RegisterCodeSent(email: _email!));
    }
  }

  Future<void> _onResend(
    ResendCodeEvent event,
    Emitter<RegisterState> emit,
  ) async {
    if (_email != null) {
      try {
        await repository.resendCode(_email!);
      } catch (_) {}
    }
  }
}
