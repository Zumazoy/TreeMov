import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:treemov/features/authorization/data/models/login_request_model.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_repository.dart';
import 'package:treemov/shared/storage/domain/repositories/secure_storage_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final SecureStorageRepository secureStorageRepository;

  LoginBloc(this.authRepository, this.secureStorageRepository)
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
        email: event.email,
        password: event.password,
      );
      final response = await authRepository.login(loginRequest);

      if (response.accessToken == null || response.refreshToken == null) {
        emit(
          LoginError(
            error: response.detail ?? 'Ошибка авторизации. Токены не получены.',
          ),
        );
        return;
      }

      await secureStorageRepository.saveOrgId('1');
      await secureStorageRepository.saveAccessToken(response.accessToken!);
      await secureStorageRepository.saveRefreshToken(response.refreshToken!);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }
}
