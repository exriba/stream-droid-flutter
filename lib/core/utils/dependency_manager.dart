import 'package:grpc/grpc.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_droid_app/core/network/droid_client.dart';
import 'package:stream_droid_app/core/utils/local_storage.dart';
import 'package:stream_droid_app/core/utils/secure_storage.dart';
import 'package:stream_droid_app/domain/services/auth_interceptor.dart';
import 'package:stream_droid_app/domain/services/event_service.dart';
import 'package:stream_droid_app/domain/services/reward_service.dart';
import 'package:stream_droid_app/domain/services/redeem_service.dart';
import 'package:stream_droid_app/domain/services/user_service.dart';
import 'package:stream_droid_app/core/constants/constants.dart' as constants;

class DependencyManager {
  static final GetIt getIt = GetIt.instance;

  static void configure() {
    getIt.registerSingleton<ILocalStorage>(LocalStorage());
    getIt.registerSingleton<ISecureStorage>(SecureStorage());
    getIt.registerSingleton<IDroidClient>(
      DroidClient(getIt<ISecureStorage>()),
    );

    ClientChannel channel = ClientChannel(
      constants.serverName,
      port: constants.serverPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        // TODO: Use secure credentials for production
      ),
    );

    getIt.registerSingleton<AuthInterceptor>(
      AuthInterceptor(getIt<ISecureStorage>()),
    );
    getIt.registerSingleton<UserService>(
      UserService(getIt<ISecureStorage>(), channel, getIt<AuthInterceptor>()),
    );
    getIt.registerSingleton<RewardService>(
      RewardService(channel, getIt<AuthInterceptor>()),
    );
    getIt.registerSingleton<RedeemService>(
      RedeemService(channel, getIt<AuthInterceptor>()),
    );
    getIt.registerSingleton<EventService>(
      EventService(channel, getIt<AuthInterceptor>()),
    );
  }
}
