import 'package:get_it/get_it.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/core/storage/storage_repository.dart';
import 'package:treemov/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:treemov/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:treemov/features/auth/presentation/blocs/token/token_bloc.dart';
import 'package:treemov/features/teacher_calendar/data/datasources/schedule_remote_data_source.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Хранилище
  getIt.registerSingleton<StorageRepository>(StorageRepository());

  // Клиент
  getIt.registerSingleton<DioClient>(
    DioClient(storageRepository: getIt<StorageRepository>()),
  );

  // Сервисы
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSource(getIt<DioClient>()),
  );
  getIt.registerSingleton<ScheduleRemoteDataSource>(
    ScheduleRemoteDataSource(getIt<DioClient>()),
  );

  // Репозитории
  getIt.registerSingleton<AuthRepositoryImpl>(
    AuthRepositoryImpl(
      tokenService: getIt<AuthRemoteDataSource>(),
      storageRepository: getIt<StorageRepository>(),
    ),
  );

  // BLoC - регистрируем фабрику, так как BLoC должен создаваться заново
  getIt.registerFactory<TokenBloc>(
    () => TokenBloc(tokenRepository: getIt<AuthRepositoryImpl>()),
  );
}
