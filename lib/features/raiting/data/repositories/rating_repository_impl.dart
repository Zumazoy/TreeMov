import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/shared/data/models/student_response_model.dart';
import '../../domain/entities/student_entity.dart';
import '../../domain/repositories/rating_repository.dart';

class RatingRepositoryImpl implements RatingRepository {
  final DioClient _dioClient;
  
  RatingRepositoryImpl(this._dioClient);
  
  @override
  Future<List<StudentEntity>> getStudents() async {
    try {
      final response = await _dioClient.get(
        ApiConstants.studentsP + ApiConstants.students,
      );
      
      if (response.statusCode != 200 || response.data is! List) {
        return [];
      }
      
      final students = <StudentEntity>[];
      
      for (var json in response.data as List) {
        try {
          final student = StudentResponseModel.fromJson(json);
          final entity = student.toEntity();
          
          final fullName = _formatName(entity.name, entity.surname);
          if (fullName.isEmpty) continue;
          
          students.add(StudentEntity(
            name: fullName,
            score: entity.score ?? 0,
            avatar: _generateAvatar(entity.name, entity.surname),
          ));
        } catch (_) {
          continue;
        }
      }
      
      students.sort((a, b) => b.score.compareTo(a.score));
      return students;
    } catch (_) {
      return [];
    }
  }
  
  @override
  Future<StudentEntity> getCurrentStudent() async {
    final students = await getStudents();
    return students.isNotEmpty 
        ? students.reduce((a, b) => a.score > b.score ? a : b)
        : StudentEntity(name: 'Текущий Ученик', score: 0, avatar: 'ТУ');
  }
  
  String _formatName(String? name, String? surname) {
    return [surname, name]
        .where((part) => part != null && part.isNotEmpty)
        .join(' ')
        .trim();
  }
  
  String _generateAvatar(String? firstName, String? surname) {
    final firstInitial = (firstName?.isNotEmpty == true) 
        ? firstName![0].toUpperCase() 
        : '';
    final lastInitial = (surname?.isNotEmpty == true) 
        ? surname![0].toUpperCase() 
        : '';
    
    String avatar = '$firstInitial$lastInitial';
    if (avatar.isEmpty) return '??';
    if (avatar.length == 1) return '$avatar$avatar';
    return avatar;
  }
}