part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterKid extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  final String parentName;
  final String parentPhone;

  const RegisterKid({
    required this.username,
    required this.email,
    required this.password,
    required this.parentName,
    required this.parentPhone,
  });

  @override
  List<Object> get props => [
    username,
    email,
    password,
    parentName,
    parentPhone,
  ];
}

class RegisterTeacher extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  final String teacherCode;

  const RegisterTeacher({
    required this.username,
    required this.email,
    required this.password,
    required this.teacherCode,
  });

  @override
  List<Object> get props => [username, email, password, teacherCode];
}
