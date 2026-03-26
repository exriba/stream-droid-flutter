import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stream_droid_app/src/interceptors/error_interceptor.dart';
import 'package:stream_droid_app/src/services/secure_storage.dart';
import 'package:stream_droid_app/src/generated/service/userservice.pbgrpc.dart';
import 'package:stream_droid_app/src/interceptors/auth_interceptor.dart';

class UserService {
  UserService(
    SecureStorage secureStorage,
    ClientChannel channel,
    AuthInterceptor authInterceptor,
    ErrorInterceptor errorInterceptor,
  )   : _storage = secureStorage,
        _client = GrpcUserServiceClient(
          channel,
          interceptors: [authInterceptor, errorInterceptor],
        );
  final Uuid _uuid = const Uuid();
  final GrpcUserServiceClient _client;
  final SecureStorage _storage;

  Future<bool> login() async {
    bool authenticated = false;
    final sessionId = _uuid.v4();
    final request = SessionRequest(sessionId: sessionId);

    try {
      final response = await _client.generateLoginUrl(request);
      final authorizationUri = Uri.parse(response.authorizationUrl);
      final canLaunchAuthorizationUri = await canLaunchUrl(authorizationUri);

      if (!canLaunchAuthorizationUri) {
        return false;
      }

      await launchUrl(authorizationUri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }

    // TODO: Review error handling here
    final stream = _client.monitorAuthenticationSessionStatus(request);

    await for (final update in stream) {
      if (update.status == SessionStatus_Status.ERROR) {
        throw Exception('Authentication error: ${update.message}');
      }

      if (update.status == SessionStatus_Status.AUTHORIZED) {
        await _storage.saveToken(token: update.accessToken);
        authenticated = true;
        break;
      }
    }

    return authenticated;
  }

  Future<void> logout() async {
    await _storage.deleteToken();
  }
}
