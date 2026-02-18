import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

// Событие отправки формы регистрации
class SubmitRegistrationEvent extends RegisterEvent {
  final String username;
  final String email;
  final String password;

  const SubmitRegistrationEvent({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [username, email, password];
}

// Событие отправки кода подтверждения
class SubmitVerificationCodeEvent extends RegisterEvent {
  final String code;

  const SubmitVerificationCodeEvent(this.code);

  @override
  List<Object> get props => [code];
}

// Событие повторной отправки кода
class ResendCodeEvent extends RegisterEvent {}
