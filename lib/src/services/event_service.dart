import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/src/generated/google/protobuf/empty.pb.dart';
import 'package:stream_droid_app/src/generated/service/eventservice.pbgrpc.dart';
import 'package:stream_droid_app/src/interceptors/auth_interceptor.dart';
import 'package:stream_droid_app/src/interceptors/error_interceptor.dart';

class EventService {
  EventService(
    ClientChannel channel,
    AuthInterceptor authInterceptor,
    ErrorInterceptor errorInterceptor,
  ) : _client = GrpcEventServiceClient(
          channel,
          interceptors: [authInterceptor, errorInterceptor],
        );

  final GrpcEventServiceClient _client;

  Stream<EventResponse> subscribe() {
    return _client.subscribe(Empty());
  }
}
