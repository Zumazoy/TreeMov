import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:treemov/features/authorization/data/models/login_request_model.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_repository.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_storage_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthStorageRepository authStorageRepository;

  LoginBloc(this.authRepository, this.authStorageRepository)
    : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final loginRequest = LoginRequestModel(
        username: event.username,
        password: event.password,
      );
      final response = await authRepository.login(loginRequest);

      if (response.accessToken == null || response.refreshToken == null) {
        emit(
          LoginFailure(
            error: response.detail ?? 'Ошибка авторизации. Токены не получены.',
          ),
        );
        return;
      }

      await authStorageRepository.saveAccessToken(response.accessToken!);
      await authStorageRepository.saveRefreshToken(response.refreshToken!);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
