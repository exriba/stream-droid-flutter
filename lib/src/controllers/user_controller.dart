import 'package:stream_droid_app/src/generated/common/user.pbenum.dart';
import 'package:stream_droid_app/src/generated/service/userservice.pbgrpc.dart';
import 'package:stream_droid_app/src/services/secure_storage.dart';
import 'package:stream_droid_app/src/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

class UserController {
  UserController(UserService service, SecureStorage storage)
      : _service = service,
        _storage = storage;

  final UserService _service;
  final SecureStorage _storage;

  Future<bool> isAuthenticated() async {
    final userResponse = await _service.authenticationStatus();
    return userResponse.user.userType != User_UserType.UNSPECIFIED;
  }

  Future<bool> login() async {
    bool authenticated = false;
    final response = await _service.authorizationUrl();
    final authorizationUri = Uri.parse(response.authorizationUrl);
    final canLaunchAuthorizationUri = await canLaunchUrl(authorizationUri);

    if (!canLaunchAuthorizationUri) {
      return authenticated;
    }

    await launchUrl(authorizationUri, mode: LaunchMode.externalApplication);
    final stream = _service.monitorAuthentication(response.sessionId);

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
