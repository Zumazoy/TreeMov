import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_repository.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_storage_repository.dart';

part 'token_event.dart';
part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final AuthRepository authRepository;
  final AuthStorageRepository authStorageRepository;

  TokenBloc({required this.authRepository, required this.authStorageRepository})
    : super(TokenInitial()) {
    on<GetTokenEvent>(_onGetToken);
    on<CheckTokenEvent>(_onCheckToken);
  }

  Future<void> _onGetToken(
    GetTokenEvent event,
    Emitter<TokenState> emit,
  ) async {
    emit(TokenLoading());
    try {
      await authRepository.login(event.username, event.password);
      final accessToken = await authStorageRepository.getAccessToken();
      final refreshToken = await authStorageRepository.getRefreshToken();

      emit(
        TokenSuccess(
          accessToken: accessToken ?? '',
          refreshToken: refreshToken ?? '',
        ),
      );
    } catch (e) {
      emit(TokenError(error: e.toString()));
    }
  }

  Future<void> _onCheckToken(
    CheckTokenEvent event,
    Emitter<TokenState> emit,
  ) async {
    emit(TokenLoading());
    try {
      final accessToken = await authStorageRepository.getAccessToken();
      final refreshToken = await authStorageRepository.getRefreshToken();

      if (accessToken != null && accessToken.isNotEmpty) {
        emit(
          TokenSuccess(
            accessToken: accessToken,
            refreshToken: refreshToken ?? '',
          ),
        );
      } else {
        emit(TokenNotExists());
      }
    } catch (e) {
      emit(TokenError(error: e.toString()));
    }
  }
}
