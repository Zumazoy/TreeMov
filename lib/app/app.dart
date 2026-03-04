import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/core/navigation/navigation_service.dart';
import 'package:treemov/core/themes/app_theme.dart';
import 'package:treemov/core/themes/theme_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (context) => getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            navigatorKey: getIt<NavigationService>().navigatorKey,
            key: ValueKey(themeMode),
            debugShowCheckedModeBanner: false,
            title: 'TreeMov App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            initialRoute: AppRoutes.home,
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
}
