import 'package:treemov/app/di/di.config.dart';

export 'di.config.dart';

class DependencyInjection {
  static void init() {
    setupDependencies();
  }

  static void reset() {
    getIt.reset();
    setupDependencies();
  }
}
