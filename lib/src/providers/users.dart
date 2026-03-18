import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/generated/common/user.pbenum.dart';
import 'package:stream_droid_app/src/providers/auth_interceptor.dart';
import 'package:stream_droid_app/src/providers/client_channel.dart';
import 'package:stream_droid_app/src/providers/secure_storage.dart';
import 'package:stream_droid_app/src/services/user_service.dart';
import 'package:stream_droid_app/src/generated/service/userservice.pbgrpc.dart';
import 'package:url_launcher/url_launcher.dart';

part 'users.g.dart';

@riverpod
UserService userService(UserServiceRef ref) {
  final clientChannel = ref.read(clientChannelProvider);
  final authInterceptor = ref.read(authInterceptorProvider);
  return UserService(clientChannel, authInterceptor);
}

@riverpod
class Users extends _$Users {
  @override
  Future<LoginUrlResponse> build() {
    final service = ref.read(userServiceProvider);
    return service.authorizationUrl();
  }

  Stream<SessionStatus> monitorAuthentication(String sessionId) {
    final service = ref.read(userServiceProvider);
    return service.monitorAuthentication(sessionId);
  }

  Future<bool> isAuthenticated() async {
    final service = ref.read(userServiceProvider);
    final userResponse = await service.authenticationStatus();
    return userResponse.user.userType != User_UserType.UNSPECIFIED;
  }

  Future<void> login(LoginUrlResponse loginUrlResponse) async {
    final service = ref.read(userServiceProvider);
    final secureStorage = ref.read(secureStorageProvider);
    final authorizationUri = Uri.parse(loginUrlResponse.authorizationUrl);
    final canLaunchAuthorizationUri = await canLaunchUrl(authorizationUri);

    if (canLaunchAuthorizationUri) {
      await launchUrl(authorizationUri, mode: LaunchMode.externalApplication);
    }

    final response = service.monitorAuthentication(loginUrlResponse.sessionId);

    await for (final update in response) {
      if (update.status == SessionStatus_Status.ERROR) {
        throw Exception('Authentication error: ${update.message}');
      }

      if (update.status == SessionStatus_Status.AUTHORIZED) {
        await secureStorage.saveToken(token: update.accessToken);
        break;
      }
    }
  }

  Future<void> logout() async {
    final secureStorage = ref.read(secureStorageProvider);
    await secureStorage.deleteToken();
    ref.invalidateSelf();
  }
}
