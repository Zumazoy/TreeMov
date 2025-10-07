import 'package:get_it/get_it.dart';
import 'package:treemov/api/core/dio_client.dart';
import 'package:treemov/api/services/token_service.dart';
import 'package:treemov/bloc/token/token_bloc.dart';
import 'package:treemov/data/local/storage_repository.dart';
import 'package:treemov/data/repositories/token_repository.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Клиент
  getIt.registerSingleton<DioClient>(DioClient());

  // Сервисы
  getIt.registerSingleton<TokenService>(TokenService(getIt<DioClient>()));

  // Репозитории
  getIt.registerSingleton<StorageRepository>(StorageRepository());
  getIt.registerSingleton<TokenRepository>(
    TokenRepository(
      tokenService: getIt<TokenService>(),
      storageRepository: getIt<StorageRepository>(),
    ),
  );

  // BLoC
  getIt.registerFactory<TokenBloc>(
    () => TokenBloc(tokenRepository: getIt<TokenRepository>()),
  );
}
