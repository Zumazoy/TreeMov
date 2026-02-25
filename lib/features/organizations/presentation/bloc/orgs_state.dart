part of 'orgs_bloc.dart';

sealed class OrgsState extends Equatable {
  const OrgsState();

  @override
  List<Object> get props => [];
}

final class OrgsInitial extends OrgsState {}

final class OrgsLoading extends OrgsState {
  const OrgsLoading();
}

final class AcceptInviteLoading extends OrgsState {
  const AcceptInviteLoading();
}

final class OrgsLoaded extends OrgsState {
  final List<OrgMemberResponseModel> organizations;
  final List<InviteResponseModel> invites;

  const OrgsLoaded({required this.organizations, required this.invites});

  @override
  List<Object> get props => [organizations, invites];
}

final class InviteAccepted extends OrgsState {
  const InviteAccepted();
}

final class OrgsError extends OrgsState {
  final String message;

  const OrgsError(this.message);

  @override
  List<Object> get props => [message];
}

final class AcceptInviteError extends OrgsState {
  final String message;

  const AcceptInviteError(this.message);

  @override
  List<Object> get props => [message];
}
