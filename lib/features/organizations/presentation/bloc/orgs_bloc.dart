import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:treemov/features/organizations/data/models/invite_response_model.dart';
import 'package:treemov/features/organizations/domain/repositories/orgs_repository.dart';
import 'package:treemov/shared/data/models/org_member_response_model.dart';

part 'orgs_event.dart';
part 'orgs_state.dart';

class OrgsBloc extends Bloc<OrgsEvent, OrgsState> {
  final OrgsRepository _orgsRepository;

  OrgsBloc(this._orgsRepository) : super(OrgsInitial()) {
    on<LoadOrgsEvent>(_onLoadOrgs);
    on<AcceptInviteEvent>(_onAcceptInvite);
  }

  Future<void> _onLoadOrgs(LoadOrgsEvent event, Emitter<OrgsState> emit) async {
    emit(OrgsLoading());
    try {
      final results = await Future.wait([
        _orgsRepository.getMyOrgs(),
        _orgsRepository.getMyInvites(),
      ]);

      final organizations = results[0] as List<OrgMemberResponseModel>;
      final invites = results[1] as List<InviteResponseModel>;

      emit(OrgsLoaded(organizations: organizations, invites: invites));
    } catch (e) {
      emit(OrgsError('Ошибка загрузки: $e'));
    }
  }

  Future<void> _onAcceptInvite(
    AcceptInviteEvent event,
    Emitter<OrgsState> emit,
  ) async {
    emit(AcceptInviteLoading());
    try {
      final success = await _orgsRepository.acceptInvite(event.inviteUuid);

      if (success) {
        emit(InviteAccepted());
        add(LoadOrgsEvent());
      } else {
        emit(AcceptInviteError('Не удалось принять приглашение'));
      }
    } catch (e) {
      emit(AcceptInviteError('Ошибка принятия приглашения: $e'));
    }
  }
}
