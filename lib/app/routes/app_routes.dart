import 'package:flutter/material.dart';
import 'package:treemov/core/network/dio_client.dart'; // ← Добавлено
import 'package:treemov/features/authorization/auth_checker_feature.dart';
import 'package:treemov/features/authorization/data/repositories/auth_storage_repository_impl.dart';
import 'package:treemov/features/authorization/presentation/screens/entrance_kid_screen.dart';
import 'package:treemov/features/authorization/presentation/screens/entrance_teacher_screen.dart';
import 'package:treemov/features/authorization/presentation/screens/test_token_screen.dart';
import 'package:treemov/features/kid_calendar/presentation/screens/calendar_kid.dart';
import 'package:treemov/features/registration/presentation/screens/kid_info_screen.dart';
import 'package:treemov/features/registration/presentation/screens/parent_info_screen.dart';
import 'package:treemov/features/registration/presentation/screens/registration_screen.dart';
import 'package:treemov/features/registration/presentation/screens/teacher_info_screen.dart';
import 'package:treemov/features/registration/presentation/screens/teacher_verification_screen.dart';
import 'package:treemov/features/teacher_calendar/presentation/screens/test_schedule_list_screen.dart';
import 'package:treemov/features/test_home/home_screen.dart';
import 'package:treemov/temp/main_screen.dart';
import 'package:treemov/features/raiting/presentation/screens/rating_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String entrance = '/entrance';
  static const String entranceKid = '/entrance_kid';
  static const String entranceTeacher = '/entrance_teacher';
  static const String registration = '/registration';
  static const String kidInfoScreen = '/kid_info_screen';
  static const String parentInfoScreen = '/parent_info_screen';
  static const String teacherVerificationScreen = '/teacher_verification_screen';
  static const String teacherInfoScreen = '/teacher_info_screen';
  static const String kidCalendar = '/kid_calendar';
  static const String mainApp = '/main_app';
  static const String teacherMainApp = '/teacher_main_app';
  static const String testHome = '/test_home';
  static const String testToken = '/test_token';
  static const String testSchedule = '/test_schedule';
  static const String rating = '/rating';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => AuthCheckerFeature.createAuthChecker(),
    entrance: (context) => AuthCheckerFeature.createEntranceScreen(),
    entranceKid: (context) => const EntranceKidScreen(),
    entranceTeacher: (context) => const EntranceTeacherScreen(),
    registration: (context) => const RegistrationScreen(),
    kidInfoScreen: (context) => const KidInfoScreen(),
    parentInfoScreen: (context) => const ParentInfoScreen(),
    teacherVerificationScreen: (context) => const TeacherVerificationScreen(),
    teacherInfoScreen: (context) => const TeacherInfoScreen(teacherCode: '1'),
    kidCalendar: (context) => const CalendarKidScreen(),
    mainApp: (context) => const MainScreen(),
    testHome: (context) => HomeScreen(),
    testToken: (context) => TokenTestScreen(),
    testSchedule: (context) => TestScheduleScreen(),
    
    // ✅ ИСПРАВЛЕНО: создаем цепочку зависимостей для RatingScreen
    rating: (context) {
      final authStorageRepository = AuthStorageRepositoryImpl();
      final dioClient = DioClient(authStorageRepository: authStorageRepository);
      return RatingScreen(dioClient: dioClient);
    },
  };
}