import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/src/generated/google/protobuf/empty.pb.dart';
import 'package:stream_droid_app/src/generated/service/eventservice.pbgrpc.dart';
import 'package:stream_droid_app/src/interceptors/auth_interceptor.dart';

class EventService {
  EventService(ClientChannel channel, AuthInterceptor authInterceptor)
      : _client = GrpcEventServiceClient(
          channel,
          interceptors: [authInterceptor],
        );

  final GrpcEventServiceClient _client;

  Stream<EventResponse> subscribe() {
    return _client.subscribe(Empty());
  }
}
