import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/base/base_remote_data_source.dart';
import 'package:treemov/shared/data/models/student_response_model.dart';

class RatingRemoteDataSource extends BaseRemoteDataSource {
  RatingRemoteDataSource(super.dioClient);

  Future<List<StudentResponseModel>> getAllStudents() {
    return getList(
      path: ApiConstants.students,
      fromJson: StudentResponseModel.fromJson,
    );
  }
}
