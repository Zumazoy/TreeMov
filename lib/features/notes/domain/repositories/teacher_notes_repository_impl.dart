// import 'package:treemov/features/notes/data/datasources/teacher_notes_remote_data_source.dart';
// import 'package:treemov/features/notes/data/models/teacher_note_request_model.dart';
// import 'package:treemov/features/notes/data/models/teacher_note_response_model.dart';
// import 'package:treemov/features/notes/domain/repositories/teacher_notes_repository.dart';

// class TeacherNotesRepositoryImpl implements TeacherNotesRepository {
//   final TeacherNotesRemoteDataSource _remote;

//   TeacherNotesRepositoryImpl(this._remote);

//   @override
//   Future<List<TeacherNoteResponseModel>> getTeacherNotes() =>
//       _remote.fetchTeacherNotes();

//   @override
//   Future<TeacherNoteResponseModel> createTeacherNote(
//     TeacherNoteRequestModel model,
//   ) => _remote.createTeacherNote(model);

//   @override
//   Future<void> deleteTeacherNote(int id) => _remote.deleteTeacherNote(id);

//   @override
//   Future<TeacherNoteResponseModel> updateTeacherNote(
//     int id,
//     TeacherNoteRequestModel model,
//   ) {
//     return _remote.updateTeacherNote(id, model);
//   }
// }
