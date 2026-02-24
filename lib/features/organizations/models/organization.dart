import 'package:equatable/equatable.dart';
import 'profile.dart';

class Organization extends Equatable {
  final int id;
  final String title;

  const Organization({
    required this.id,
    required this.title,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }

  @override
  List<Object?> get props => [id, title];
}

class OrganizationMember extends Equatable {
  final int id;
  final Profile profile;
  final ProfileRole role;
  final Organization org;

  const OrganizationMember({
    required this.id,
    required this.profile,
    required this.role,
    required this.org,
  });

  factory OrganizationMember.fromJson(Map<String, dynamic> json) {
    return OrganizationMember(
      id: json['id'] as int,
      profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
      role: ProfileRole.fromJson(json['role'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile': profile.toJson(),
      'role': role.toJson(),
      'org': org.toJson(),
    };
  }

  String get organizationName => org.title;
  String get memberName => profile.fullName;
  String get memberEmail => profile.email ?? '';
  String get roleCode => role.code;
  String get roleTitle => role.title;
  
  bool get isAdmin => role.code == 'admin';
  bool get isMember => role.code == 'member';
  bool get isPending => role.code == 'pending'; 
  bool get isInvited => role.code == 'invited';  

  @override
  List<Object?> get props => [id, profile, role, org];
}

class OrganizationCreateRequest {
  final String title;

  OrganizationCreateRequest({
    required this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}

extension ListOrganizationMemberExtension on List<OrganizationMember> {
  List<OrganizationMember> get admins => where((m) => m.isAdmin).toList();
  List<OrganizationMember> get members => where((m) => m.isMember).toList();
  List<OrganizationMember> get pending => where((m) => m.isPending).toList();
  List<OrganizationMember> get invited => where((m) => m.isInvited).toList();

  Map<String, List<OrganizationMember>> groupByRole() {
    final Map<String, List<OrganizationMember>> result = {};
    for (final member in this) {
      result.putIfAbsent(member.roleCode, () => []).add(member);
    }
    return result;
  }
}

class MockOrganizationData {
  static List<OrganizationMember> getMockMembers() {
    return [
      OrganizationMember(
        id: 1,
        profile: Profile(
          id: 1,
          userId: 1,
          name: 'Иван',
          surname: 'Иванов',
          patronymic: 'Иванович',
          email: 'ivan@example.com',
        ),
        role: ProfileRole(
          id: 1,
          title: 'Администратор',
          code: 'admin',
        ),
        org: Organization(id: 1, title: 'Школа №1'),
      ),
      OrganizationMember(
        id: 2,
        profile: Profile(
          id: 2,
          userId: 2,
          name: 'Мария',
          surname: 'Петрова',
          patronymic: 'Сергеевна',
          email: 'maria@example.com',
        ),
        role: ProfileRole(
          id: 2,
          title: 'Учитель',
          code: 'member',
        ),
        org: Organization(id: 1, title: 'Школа №1'),
      ),
    ];
  }

  static List<OrganizationMember> getMockInvites() {
    return [
      OrganizationMember(
        id: 3,
        profile: Profile(
          id: 3,
          userId: 3,
          email: 'newuser@example.com',
        ),
        role: ProfileRole(
          id: 2,
          title: 'Учитель',
          code: 'pending',
        ),
        org: Organization(id: 1, title: 'Школа №1'),
      ),
    ];
  }
}