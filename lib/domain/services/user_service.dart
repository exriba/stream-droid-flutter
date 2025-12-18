import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';
import 'package:stream_droid_app/domain/generated/common/user.pbenum.dart';
import 'package:stream_droid_app/core/utils/secure_storage.dart';
import 'package:stream_droid_app/domain/generated/google/protobuf/empty.pb.dart';
import 'package:stream_droid_app/domain/generated/service/userservice.pbgrpc.dart';
import 'package:stream_droid_app/domain/services/auth_interceptor.dart';

class UserService {
  UserService(this._secureStorage, ClientChannel channel,
      AuthInterceptor authInterceptor) {
    _client = GrpcUserServiceClient(channel, interceptors: [authInterceptor]);
  }
  final Uuid _uuid = const Uuid();
  final ISecureStorage _secureStorage;
  late GrpcUserServiceClient _client;
  late String _sessionId = '';

  Future<String> authorizationUrl() async {
    _sessionId = _uuid.v4();
    final request = SessionRequest(sessionId: _sessionId);
    final response = await _client.generateLoginUrl(request);
    return response.authorizationUrl;
  }

  ResponseStream<SessionStatus> monitorAuthentication() {
    final sessionRequest = SessionRequest(sessionId: _sessionId);
    return _client.monitorAuthenticationSessionStatus(sessionRequest);
  }

  Future<bool> authenticationStatus() async {
    final response = await _client.findUser(Empty());
    return response.user.userType != User_UserType.UNSPECIFIED;
  }

  Future<void> login(SessionStatus update) async {
    await _secureStorage.saveToken(token: update.accessToken);
  }

  Future<void> logout() async {
    await _secureStorage.deleteToken();
  }
}
