import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/student_in_group_response_model.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

part 'directory_event.dart';
part 'directory_state.dart';

class DirectoryBloc extends Bloc<DirectoryEvent, DirectoryState> {
  final SharedRepository _sharedRepository;

  DirectoryBloc(this._sharedRepository) : super(DirectoryInitial()) {
    on<LoadStudentGroups>(_onLoadStudentGroups);
    on<LoadStudentsInGroup>(_onLoadStudentsInGroup);
    on<LoadAllGroupsWithCounts>(_onLoadAllGroupsWithCounts);
  }

  Future<void> _onLoadStudentGroups(
    LoadStudentGroups event,
    Emitter<DirectoryState> emit,
  ) async {
    emit(DirectoryLoading());
    try {
      final groups = await _sharedRepository.getGroupStudents();
      emit(GroupsLoaded(groups: groups));
    } catch (e) {
      emit(DirectoryError(e.toString()));
    }
  }

  Future<void> _onLoadStudentsInGroup(
    LoadStudentsInGroup event,
    Emitter<DirectoryState> emit,
  ) async {
    emit(StudentsLoading());
    try {
      final students = await _sharedRepository.getStudentsInGroup(
        event.groupId,
      );
      emit(StudentsInGroupLoaded(students: students, groupId: event.groupId));
    } catch (e) {
      emit(DirectoryError(e.toString()));
    }
  }

  Future<void> _onLoadAllGroupsWithCounts(
    LoadAllGroupsWithCounts event,
    Emitter<DirectoryState> emit,
  ) async {
    emit(DirectoryLoading());
    try {
      // Сначала загружаем все группы
      final groups = await _sharedRepository.getGroupStudents();

      // Затем для каждой группы загружаем студентов и считаем их количество
      final Map<int, int> groupStudentCounts = {};
      final Map<int, List<StudentInGroupResponseModel>> groupStudents = {};

      for (var group in groups) {
        if (group.id != null) {
          try {
            final students = await _sharedRepository.getStudentsInGroup(
              group.id!,
            );
            groupStudentCounts[group.id!] = students.length;
            groupStudents[group.id!] = students;
          } catch (e) {
            // Если не удалось загрузить студентов для группы, ставим 0
            groupStudentCounts[group.id!] = 0;
            groupStudents[group.id!] = [];
          }
        }
      }

      emit(
        GroupsWithCountsLoaded(
          groups: groups,
          groupStudentCounts: groupStudentCounts,
          groupStudents: groupStudents,
        ),
      );
    } catch (e) {
      emit(DirectoryError(e.toString()));
    }
  }
}
