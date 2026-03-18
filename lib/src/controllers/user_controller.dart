import 'package:stream_droid_app/src/generated/common/user.pbenum.dart';
import 'package:stream_droid_app/src/generated/service/userservice.pbgrpc.dart';
import 'package:stream_droid_app/src/services/secure_storage.dart';
import 'package:stream_droid_app/src/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

class UserController {
  UserController({required this.service, required this.storage});
  final UserService service;
  final SecureStorage storage;

  Future<bool> isAuthenticated() async {
    final userResponse = await service.authenticationStatus();
    return userResponse.user.userType != User_UserType.UNSPECIFIED;
  }

  Future<bool> login() async {
    bool authenticated = false;
    final response = await service.authorizationUrl();
    final authorizationUri = Uri.parse(response.authorizationUrl);
    final canLaunchAuthorizationUri = await canLaunchUrl(authorizationUri);

    if (!canLaunchAuthorizationUri) {
      return authenticated;
    }

    await launchUrl(authorizationUri, mode: LaunchMode.externalApplication);
    final stream = service.monitorAuthentication(response.sessionId);

    await for (final update in stream) {
      if (update.status == SessionStatus_Status.ERROR) {
        throw Exception('Authentication error: ${update.message}');
      }

      if (update.status == SessionStatus_Status.AUTHORIZED) {
        await storage.saveToken(token: update.accessToken);
        authenticated = true;
        break;
      }
    }

    return authenticated;
  }

  Future<void> logout() async {
    await storage.deleteToken();
  }
}
