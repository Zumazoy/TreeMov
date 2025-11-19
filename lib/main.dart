import 'package:flutter/material.dart';
import 'package:treemov/app/app.dart';
import 'package:treemov/app/di/di.dart';
import 'package:treemov/debug/test_teacher_note.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  testTeacherNote();

  // Инициализация DI до запуска приложения
  DependencyInjection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
