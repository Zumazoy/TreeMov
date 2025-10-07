import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:treemov/data/repositories/token_repository.dart';

part 'token_event.dart';
part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final TokenRepository tokenRepository;

  TokenBloc({required this.tokenRepository}) : super(TokenInitial()) {
    on<GetTokenEvent>(_onGetToken);
    on<CheckTokenEvent>(_onCheckToken);
    // on<ClearTokenEvent>(_onClearToken);
  }

  Future<void> _onGetToken(
    GetTokenEvent event,
    Emitter<TokenState> emit,
  ) async {
    emit(TokenLoading());
    try {
      await tokenRepository.getToken(event.username, event.password);
      final accessToken = await tokenRepository.getAccessToken();
      final refreshToken = await tokenRepository.getRefreshToken();

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
      final accessToken = await tokenRepository.getAccessToken();
      final refreshToken = await tokenRepository.getRefreshToken();

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

  // Future<void> _onClearToken(
  //   ClearTokenEvent event,
  //   Emitter<TokenState> emit,
  // ) async {
  //   try {
  //     // В текущей реализации нет метода удаления, но можно добавить
  //     // await tokenRepository.deleteTokens();
  //     emit(TokenCleared());
  //   } catch (e) {
  //     emit(TokenError(error: e.toString()));
  //   }
  // }
}
