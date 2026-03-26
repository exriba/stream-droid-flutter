import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/src/generated/google/protobuf/empty.pb.dart';
import 'package:stream_droid_app/src/generated/service/redeemservice.pbgrpc.dart';
import 'package:stream_droid_app/src/interceptors/auth_interceptor.dart';
import 'package:stream_droid_app/src/interceptors/error_interceptor.dart';

class RedeemService {
  RedeemService(
    ClientChannel channel,
    AuthInterceptor authInterceptor,
    ErrorInterceptor errorInterceptor,
  ) : _client = GrpcRedeemServiceClient(
          channel,
          interceptors: [authInterceptor, errorInterceptor],
        );

  final GrpcRedeemServiceClient _client;

  Future<RewardRedeemResponse> fetchRewardRedeems() {
    return _client.findRewardRedeemStatisticsFromUser(Empty());
  }
}
