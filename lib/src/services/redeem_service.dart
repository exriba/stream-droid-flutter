import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/src/generated/google/protobuf/empty.pb.dart';
import 'package:stream_droid_app/src/generated/service/redeemservice.pbgrpc.dart';
import 'package:stream_droid_app/src/interceptors/auth_interceptor.dart';

class RedeemService {
  RedeemService(ClientChannel channel, AuthInterceptor authInterceptor) {
    _client = GrpcRedeemServiceClient(channel, interceptors: [authInterceptor]);
  }
  late GrpcRedeemServiceClient _client;

  Future<RewardRedeemResponse> fetchRewardRedeems() {
    return _client.findRewardRedeemStatisticsFromUser(Empty());
  }
}
