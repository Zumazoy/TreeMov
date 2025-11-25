import 'package:flutter/material.dart';
import 'package:treemov/app/app.dart';
import 'package:treemov/app/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
