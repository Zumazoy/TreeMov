part of 'token_bloc.dart';

@immutable
abstract class TokenState {}

class TokenInitial extends TokenState {}

class TokenLoading extends TokenState {}

class TokenSuccess extends TokenState {
  final String accessToken;
  final String refreshToken;

  TokenSuccess({required this.accessToken, required this.refreshToken});
}

class TokenError extends TokenState {
  final String error;

  TokenError({required this.error});
}

class TokenNotExists extends TokenState {}
