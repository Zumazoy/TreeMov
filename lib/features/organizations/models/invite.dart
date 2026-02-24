import 'package:equatable/equatable.dart';
import 'profile.dart';

enum InviteStatus {
  sending, sent, accepted, expired, cancelled;

  static InviteStatus fromString(String status) {
    switch (status) {
      case 'SENDING': return InviteStatus.sending;
      case 'SENT': return InviteStatus.sent;
      case 'ACCEPTED': return InviteStatus.accepted;
      case 'EXPIRED': return InviteStatus.expired;
      case 'CANCELLED': return InviteStatus.cancelled;
      default: return InviteStatus.sending;
    }
  }
}

class Invite extends Equatable {
  final int id;
  final String? uuid; 
  final InviteStatus status;
  final ProfileRole role;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Invite({
    required this.id,
    this.uuid, 
    required this.status,
    required this.role,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Invite.fromJson(Map<String, dynamic> json) {
    return Invite(
      id: json['id'] as int,
      uuid: json['uuid'] as String?, 
      status: InviteStatus.fromString(json['status'] as String),
      role: ProfileRole.fromJson(json['role'] as Map<String, dynamic>),
      email: json['email'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  List<Object?> get props => [id, uuid, status, role, email, createdAt, updatedAt];
}

class InviteCreateRequest {
  final int roleId;
  final String email;
  InviteCreateRequest({required this.roleId, required this.email});
  Map<String, dynamic> toJson() => {'role_id': roleId, 'email': email};
}