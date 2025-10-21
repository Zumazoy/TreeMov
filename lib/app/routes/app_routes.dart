import 'package:flutter/material.dart';
import 'package:treemov/features/auth/presentation/pages/login/entrance_kid.dart';
import 'package:treemov/features/auth/presentation/pages/login/entrance_screen.dart';
import 'package:treemov/features/auth/presentation/pages/login/entrance_teacher.dart';
import 'package:treemov/features/auth/presentation/pages/login/test_token_screen.dart';
import 'package:treemov/features/auth/presentation/pages/register/reg_kid1.dart';
import 'package:treemov/features/auth/presentation/pages/register/reg_kid2.dart';
import 'package:treemov/features/auth/presentation/pages/register/reg_teacher1.dart';
import 'package:treemov/features/auth/presentation/pages/register/reg_teacher2.dart';
import 'package:treemov/features/kid_calendar/presentation/pages/calendar_kid.dart';
import 'package:treemov/features/teacher_calendar/presentation/pages/test_create_schedule.dart';
import 'package:treemov/features/teacher_calendar/presentation/pages/test_schedule_list_screen.dart';
import 'package:treemov/features/test_home/home_screen.dart';
import 'package:treemov/temp/main_screen.dart';

class AppRoutes {
  static const String entrance = '/entrance';
  static const String entranceKid = '/entrance-kid';
  static const String entranceTeacher = '/entrance-teacher';

  static const String regKid1 = '/reg-kid-1';
  static const String regKid2 = '/reg-kid-2';
  static const String regTeacher1 = '/reg-teacher-1';
  static const String regTeacher2 = '/reg-teacher-2';

  static const String kidCalendar = '/kidCalendar';

  static const String mainApp = '/main-app';
  static const String teacherMainApp = '/teacher-main-app';

  static const String testHome = '/home';
  static const String testToken = '/test_token';
  static const String testSchedule = '/test_schedule';
  static const String createSchedule = '/create_schedule';

  static final Map<String, WidgetBuilder> routes = {
    entrance: (context) => const EntranceScreen(),
    entranceKid: (context) => const EntranceKidScreen(),
    entranceTeacher: (context) => const EntranceTeacherScreen(),
    regKid1: (context) => const RegKid1Screen(),
    regKid2: (context) => const RegKid2Screen(),
    regTeacher1: (context) => const RegTeacher1Screen(),
    regTeacher2: (context) => const RegTeacher2Screen(),
    kidCalendar: (context) => const CalendarKidScreen(),
    mainApp: (context) => const MainScreen(),
    testHome: (context) => HomeScreen(),
    testToken: (context) => TokenTestScreen(),
    testSchedule: (context) => TestScheduleScreen(),
    createSchedule: (context) => const CreateScheduleScreen(),
  };
}
