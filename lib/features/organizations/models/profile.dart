import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final int id;
  final int userId;
  final String? email;
  final String? name;
  final String? surname;
  final String? patronymic;

  const Profile({
    required this.id,
    required this.userId,
    this.email,
    this.name,
    this.surname,
    this.patronymic,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      email: json['email'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      patronymic: json['pathronamic'] as String?, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (surname != null) 'surname': surname,
      'pathronamic': patronymic,
    };
  }

  String get fullName {
    final parts = [surname, name, patronymic].where((e) => e != null && e.isNotEmpty);
    return parts.isNotEmpty ? parts.join(' ') : 'Без имени';
  }

  @override
  List<Object?> get props => [id, userId, email, name, surname, patronymic];
}

class ProfileRole extends Equatable {
  final int id;
  final String title;
  final String code;

  const ProfileRole({
    required this.id,
    required this.title,
    required this.code,
  });

  factory ProfileRole.fromJson(Map<String, dynamic> json) {
    return ProfileRole(
      id: json['id'] as int,
      title: json['title'] as String,
      code: json['code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'code': code,
    };
  }

  @override
  List<Object?> get props => [id, title, code];
}