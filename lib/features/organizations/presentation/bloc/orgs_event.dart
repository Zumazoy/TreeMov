part of 'orgs_bloc.dart';

sealed class OrgsEvent extends Equatable {
  const OrgsEvent();

  @override
  List<Object> get props => [];
}

class LoadOrgsEvent extends OrgsEvent {
  const LoadOrgsEvent();
}

class AcceptInviteEvent extends OrgsEvent {
  final String inviteUuid;

  const AcceptInviteEvent(this.inviteUuid);

  @override
  List<Object> get props => [inviteUuid];
}
