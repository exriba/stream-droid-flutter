import 'package:get_it/get_it.dart';
import 'package:stream_droid_app/core/network/droid_client.dart';
import 'package:stream_droid_app/core/utils/local_storage.dart';
import 'package:stream_droid_app/core/utils/secure_storage.dart';
import 'package:stream_droid_app/domain/services/auth_interceptor.dart';
import 'package:stream_droid_app/domain/services/reward_service.dart';
import 'package:stream_droid_app/domain/services/redeem_service.dart';
import 'package:stream_droid_app/domain/services/user_service.dart';

class DependencyManager {
  static final GetIt getIt = GetIt.instance;

  static void configure() {
    getIt.registerSingleton<ILocalStorage>(LocalStorage());
    getIt.registerSingleton<ISecureStorage>(SecureStorage());
    getIt.registerSingleton<AuthInterceptor>(
      AuthInterceptor(getIt<ISecureStorage>()),
    );
    getIt.registerSingleton<IDroidClient>(
      DroidClient(getIt<ISecureStorage>()),
    );
    getIt.registerSingleton<UserService>(
      UserService(getIt<ISecureStorage>(), getIt<AuthInterceptor>()),
    );
    getIt.registerSingleton<RewardService>(
      RewardService(getIt<IDroidClient>()),
    );
    getIt.registerSingleton<RedeemService>(
      RedeemService(getIt<AuthInterceptor>()),
    );
  }
}
