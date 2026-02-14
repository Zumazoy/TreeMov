// import 'package:treemov/core/constants/api_constants.dart';
// import 'package:treemov/core/network/dio_client.dart';
// import 'package:treemov/features/notes/data/models/teacher_note_request_model.dart';
// import 'package:treemov/features/notes/data/models/teacher_note_response_model.dart';

// class TeacherNotesRemoteDataSource {
//   final DioClient _dioClient;

//   TeacherNotesRemoteDataSource(this._dioClient);

//   Future<List<TeacherNoteResponseModel>> fetchTeacherNotes() async {
//     final response = await _dioClient.get(
//       ApiConstants.employeesP + ApiConstants.teacherNotes,
//     );
//     if (response.statusCode == 200 && response.data is List) {
//       return (response.data as List)
//           .whereType<Map<String, dynamic>>()
//           .map((json) => TeacherNoteResponseModel.fromJson(json))
//           .toList();
//     }
//     return [];
//   }

//   Future<TeacherNoteResponseModel> createTeacherNote(
//     TeacherNoteRequestModel model,
//   ) async {
//     final response = await _dioClient.post(
//       ApiConstants.employeesP + ApiConstants.teacherNotes,
//       data: model.toJson(),
//     );
//     if ((response.statusCode == 200 || response.statusCode == 201) &&
//         response.data is Map) {
//       return TeacherNoteResponseModel.fromJson(
//         Map<String, dynamic>.from(response.data),
//       );
//     }
//     throw Exception('Failed to create teacher note: ${response.statusCode}');
//   }

//   /// DELETE /teacher-notes/{id}/
//   Future<void> deleteTeacherNote(int id) async {
//     final response = await _dioClient.delete(
//       '${ApiConstants.employeesP + ApiConstants.teacherNotes}$id/',
//     );
//     if (response.statusCode == 200 || response.statusCode == 204) {
//       return;
//     }
//     throw Exception('Failed to delete teacher note: ${response.statusCode}');
//   }

//   /// PATCH /teacher-notes/{id}/
//   Future<TeacherNoteResponseModel> updateTeacherNote(
//     int id,
//     TeacherNoteRequestModel model,
//   ) async {
//     final response = await _dioClient.patch(
//       '${ApiConstants.employeesP + ApiConstants.teacherNotes}$id/',
//       data: model.toJson(),
//     );
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       return TeacherNoteResponseModel.fromJson(
//         Map<String, dynamic>.from(response.data),
//       );
//     }
//     throw Exception(
//       'Failed to update teacher note (PATCH): ${response.statusCode}',
//     );
//   }
// }
