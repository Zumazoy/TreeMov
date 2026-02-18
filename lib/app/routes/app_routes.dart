import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/authorization/auth_checker_feature.dart';
import 'package:treemov/features/authorization/presentation/screens/entrance_kid_screen.dart';
import 'package:treemov/features/authorization/presentation/screens/entrance_teacher_screen.dart';
import 'package:treemov/features/kid_calendar/presentation/screens/calendar_kid.dart';
import 'package:treemov/features/raiting/presentation/screens/rating_screen.dart';
import 'package:treemov/features/registration/presentation/bloc/register_bloc.dart';
import 'package:treemov/features/registration/presentation/screens/registration_screen.dart';
import 'package:treemov/features/registration/presentation/screens/verification_code_screen.dart';
// import 'package:treemov/features/test_home/home_screen.dart';
import 'package:treemov/shared/storage/data/repositories/secure_storage_repository_impl.dart';
import 'package:treemov/temp/main_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String entrance = '/entrance';
  static const String entranceKid = '/entrance_kid';
  static const String entranceTeacher = '/entrance_teacher';
  // static const String kidInfoScreen = '/kid_info_screen';
  // static const String parentInfoScreen = '/parent_info_screen';
  // static const String teacherVerificationScreen =
  //     '/teacher_verification_screen';
  // static const String teacherInfoScreen = '/teacher_info_screen';
  static const String kidCalendar = '/kid_calendar';
  static const String mainApp = '/main_app';
  static const String teacherMainApp = '/teacher_main_app';
  static const String testHome = '/test_home';
  static const String testToken = '/test_token';
  static const String testSchedule = '/test_schedule';
  static const String rating = '/rating';

  static const String registration = '/registration';
  static const String verificationCode = '/verification_code';
  static const String teacherProfile = '/teacher_profile';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => AuthCheckerFeature.createAuthChecker(),
    entrance: (context) => AuthCheckerFeature.createEntranceScreen(),
    entranceKid: (context) => const EntranceKidScreen(),
    entranceTeacher: (context) => const EntranceTeacherScreen(),
    registration: (context) => BlocProvider(
      create: (context) => getIt<RegisterBloc>(),
      child: const RegistrationScreen(),
    ),
    verificationCode: (context) => const VerificationCodeScreen(),
    // kidInfoScreen: (context) => const KidInfoScreen(),
    // parentInfoScreen: (context) => const ParentInfoScreen(),
    // teacherVerificationScreen: (context) => const TeacherVerificationScreen(),
    // teacherInfoScreen: (context) => const TeacherInfoScreen(teacherCode: '1'),
    kidCalendar: (context) => const CalendarKidScreen(),
    mainApp: (context) => const MainScreen(),
    // testHome: (context) => HomeScreen(),

    // testToken: (context) => TokenTestScreen(),
    rating: (context) {
      final secureStorageRepository = SecureStorageRepositoryImpl();
      final dioClient = DioClient(secureStorage: secureStorageRepository);
      return RatingScreen(dioClient: dioClient);
    },
  };
}
