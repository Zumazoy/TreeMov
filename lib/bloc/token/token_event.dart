part of 'token_bloc.dart';

@immutable
abstract class TokenEvent {}

class GetTokenEvent extends TokenEvent {
  final String username;
  final String password;

  GetTokenEvent({required this.username, required this.password});
}

class CheckTokenEvent extends TokenEvent {}

// class ClearTokenEvent extends TokenEvent {}
