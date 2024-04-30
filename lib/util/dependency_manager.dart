import 'package:get_it/get_it.dart';
import 'package:stream_droid_app/api/custom_http_client.dart';
import 'package:stream_droid_app/api/custom_http_server.dart';
import 'package:stream_droid_app/util/local_storage.dart';
import 'package:stream_droid_app/util/secure_storage.dart';

class DependencyManager {
  static GetIt getIt = GetIt.instance;

  static void configure() {
    getIt.registerSingleton<ILocalStorage>(LocalStorage());
    getIt.registerSingleton<ISecureStorage>(SecureStorage());
    getIt.registerSingleton<ICustomHttpClient>(CustomHttpClient());
    getIt.registerSingleton<ICustomHttpServer>(CustomHttpServer());
  }
}
