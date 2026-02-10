part of 'token_bloc.dart';

@immutable
abstract class TokenEvent {}

class GetTokenEvent extends TokenEvent {
  final String email;
  final String password;

  GetTokenEvent({required this.email, required this.password});
}

class CheckTokenEvent extends TokenEvent {}
