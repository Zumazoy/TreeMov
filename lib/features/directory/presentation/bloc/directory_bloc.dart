import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

part 'directory_event.dart';
part 'directory_state.dart';

class DirectoryBloc extends Bloc<DirectoryEvent, DirectoryState> {
  final SharedRepository _sharedRepository;

  DirectoryBloc(this._sharedRepository) : super(DirectoryInitial()) {
    on<LoadStudentGroups>(_onLoadStudentGroups);
  }

  Future<void> _onLoadStudentGroups(
    LoadStudentGroups event,
    Emitter<DirectoryState> emit,
  ) async {
    emit(DirectoryLoading());
    try {
      final groups = await _sharedRepository.getGroupStudents();
      emit(GroupsLoaded(groups));
    } catch (e) {
      emit(DirectoryError(e.toString()));
    }
  }
}
