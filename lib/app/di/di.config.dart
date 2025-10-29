import 'package:get_it/get_it.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/authorization/data/datasources/auth_remote_data_source.dart';
import 'package:treemov/features/authorization/data/repositories/auth_repository_impl.dart';
import 'package:treemov/features/authorization/data/repositories/auth_storage_repository_impl.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_repository.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_storage_repository.dart';
import 'package:treemov/features/authorization/presentation/blocs/token/token_bloc.dart';
import 'package:treemov/features/teacher_calendar/data/datasources/schedule_remote_data_source.dart';
import 'package:treemov/features/teacher_calendar/data/repositories/schedule_repository_impl.dart';
import 'package:treemov/features/teacher_calendar/domain/repositories/schedule_repository.dart';
import 'package:treemov/features/teacher_calendar/presentation/blocs/schedules/schedules_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Локальные хранилища
  getIt.registerSingleton<AuthStorageRepository>(AuthStorageRepositoryImpl());

  // Клиент
  getIt.registerSingleton<DioClient>(
    DioClient(authStorageRepository: getIt<AuthStorageRepository>()),
  );

  // Сервисы
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSource(getIt<DioClient>()),
  );
  getIt.registerSingleton<ScheduleRemoteDataSource>(
    ScheduleRemoteDataSource(getIt<DioClient>()),
  );

  // Репозитории
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      authRemoteDataSource: getIt<AuthRemoteDataSource>(),
      authStorageRepository: getIt<AuthStorageRepository>(),
    ),
  );
  getIt.registerSingleton<ScheduleRepository>(
    ScheduleRepositoryImpl(getIt<ScheduleRemoteDataSource>()),
  );

  // BLoC - регистрируем фабрику, так как BLoC должен создаваться заново
  getIt.registerFactory<TokenBloc>(
    () => TokenBloc(
      authRepository: getIt<AuthRepository>(),
      authStorageRepository: getIt<AuthStorageRepository>(),
    ),
  );
  getIt.registerFactory<SchedulesBloc>(
    () => SchedulesBloc(getIt<ScheduleRepository>()),
  );
}
