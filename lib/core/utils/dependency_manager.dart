import 'package:get_it/get_it.dart';
import 'package:stream_droid_app/core/network/droid_client.dart';
import 'package:stream_droid_app/core/utils/local_storage.dart';
import 'package:stream_droid_app/core/utils/secure_storage.dart';

class DependencyManager {
  static final GetIt getIt = GetIt.instance;

  static void configure() {
    getIt.registerSingleton<ILocalStorage>(LocalStorage());
    getIt.registerSingleton<ISecureStorage>(SecureStorage());
    getIt.registerSingleton<IDroidClient>(
      DroidClient(getIt<ISecureStorage>()),
    );
  }
}
