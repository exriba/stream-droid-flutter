import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/domain/generated/google/protobuf/empty.pb.dart';
import 'package:stream_droid_app/domain/generated/service/eventservice.pbgrpc.dart';
import 'package:stream_droid_app/domain/interceptors/auth_interceptor.dart';

class EventService {
  EventService(ClientChannel channel, AuthInterceptor authInterceptor) {
    _client = GrpcEventServiceClient(channel, interceptors: [authInterceptor]);
  }
  late GrpcEventServiceClient _client;

  ResponseStream<EventResponse> listen() {
    return _client.subscribe(Empty());
  }
}
