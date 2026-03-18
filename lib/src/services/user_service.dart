import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';
import 'package:stream_droid_app/src/generated/google/protobuf/empty.pb.dart';
import 'package:stream_droid_app/src/generated/service/userservice.pbgrpc.dart';
import 'package:stream_droid_app/src/interceptors/auth_interceptor.dart';

class UserService {
  UserService(ClientChannel channel, AuthInterceptor authInterceptor)
      : _client = GrpcUserServiceClient(
          channel,
          interceptors: [authInterceptor],
        );
  final Uuid _uuid = const Uuid();
  final GrpcUserServiceClient _client;

  Future<LoginUrlResponse> authorizationUrl() {
    final sessionId = _uuid.v4();
    final request = SessionRequest(sessionId: sessionId);
    return _client.generateLoginUrl(request);
  }

  Stream<SessionStatus> monitorAuthentication(String sessionId) {
    final sessionRequest = SessionRequest(sessionId: sessionId);
    return _client.monitorAuthenticationSessionStatus(sessionRequest);
  }

  Future<UserResponse> authenticationStatus() {
    return _client.findUser(Empty());
  }
}
