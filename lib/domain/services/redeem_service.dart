import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/domain/generated/common/redeem.pb.dart';
import 'package:stream_droid_app/domain/generated/google/protobuf/empty.pb.dart';
import 'package:stream_droid_app/domain/generated/service/redeemservice.pbgrpc.dart';
import 'package:stream_droid_app/domain/services/auth_interceptor.dart';

// TODO: handle errors for all these methods.
class RedeemService {
  RedeemService(ClientChannel channel, AuthInterceptor authInterceptor) {
    _client = GrpcRedeemServiceClient(channel, interceptors: [authInterceptor]);
  }
  late GrpcRedeemServiceClient _client;

  Future<List<RewardRedeem>> fetchRewardRedeems() async {
    final emptyRequest = Empty();
    final rewardRedeemResponse =
        await _client.findRewardRedeemStatisticsFromUser(emptyRequest);
    return rewardRedeemResponse.rewardRedeems;
  }
}
