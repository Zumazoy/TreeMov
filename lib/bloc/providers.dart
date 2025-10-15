import 'package:get_it/get_it.dart';
import 'package:treemov/api/core/dio_client.dart';
import 'package:treemov/api/services/schedule_service.dart';
import 'package:treemov/api/services/token_service.dart';
import 'package:treemov/bloc/token/token_bloc.dart';
import 'package:treemov/data/local/storage_repository.dart';
import 'package:treemov/data/repositories/token_repository.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Хранилище
  getIt.registerSingleton<StorageRepository>(StorageRepository());

  // Клиент
  getIt.registerSingleton<DioClient>(
    DioClient(storageRepository: getIt<StorageRepository>()),
  );

  // Сервисы
  getIt.registerSingleton<TokenService>(TokenService(getIt<DioClient>()));
  getIt.registerSingleton<ScheduleService>(ScheduleService(getIt<DioClient>()));

  // Репозитории
  getIt.registerSingleton<TokenRepository>(
    TokenRepository(
      tokenService: getIt<TokenService>(),
      storageRepository: getIt<StorageRepository>(),
    ),
  );

  // BLoC - регистрируем фабрику, так как BLoC должен создаваться заново
  getIt.registerFactory<TokenBloc>(
    () => TokenBloc(tokenRepository: getIt<TokenRepository>()),
  );
}
