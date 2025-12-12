import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';
import 'package:stream_droid_app/core/utils/secure_storage.dart';
import 'package:stream_droid_app/core/constants/constants.dart' as constants;
import 'package:stream_droid_app/domain/generated/common/user.pbenum.dart';
import 'package:stream_droid_app/domain/generated/google/protobuf/empty.pb.dart';
import 'package:stream_droid_app/domain/generated/service/userservice.pbgrpc.dart';
import 'package:stream_droid_app/domain/services/auth_interceptor.dart';

// TODO: handle errors for all these methods.
class UserService {
  UserService(this._secureStorage, ClientChannel channel,
      AuthInterceptor authInterceptor) {
    _client = GrpcUserServiceClient(channel, interceptors: [authInterceptor]);
  }
  final ISecureStorage _secureStorage;
  final Uuid uuid = const Uuid();
  late GrpcUserServiceClient _client;
  late String _sessionId = '';

  Future<String> authorizationUrl() async {
    _sessionId = uuid.v4();
    final sessionRequest = SessionRequest(sessionId: _sessionId);
    final sessionResponse = await _client.generateLoginUrl(sessionRequest);
    return sessionResponse.authorizationUrl;
  }

  Future<void> monitorAuthentication() async {
    final sessionRequest = SessionRequest(sessionId: _sessionId);
    final response = _client.monitorAuthenticationSessionStatus(sessionRequest);

    await for (final update in response) {
      if (update.status == SessionStatus_Status.ERROR) {
        print(update.message);
        break;
      }

      if (update.status == SessionStatus_Status.AUTHORIZED) {
        await _secureStorage.write(
            key: constants.appName, value: update.accessToken);
        break;
      }

      await Future.delayed(const Duration(milliseconds: 1000));
    }
  }

  Future<bool> isAuthenticated() async {
    final emptyRequest = Empty();
    final meResponse = await _client.findUser(emptyRequest);
    return meResponse.user.userType != User_UserType.UNSPECIFIED;
  }

  Future<void> onLogout() async {
    await _secureStorage.delete(key: constants.appName);
  }
}
