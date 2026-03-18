import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/generated/google/protobuf/empty.pb.dart';
import 'package:stream_droid_app/src/generated/service/rewardservice.pbgrpc.dart';
import 'package:stream_droid_app/src/interceptors/auth_interceptor.dart';

class RewardService {
  RewardService(ClientChannel channel, AuthInterceptor authInterceptor)
      : _client = GrpcRewardServiceClient(
          channel,
          interceptors: [authInterceptor],
        );

  final GrpcRewardServiceClient _client;

  Stream<RewardResponse> fetchRewards() {
    return _client.findUserRewards(Empty());
  }

  Future<RewardResponse> fetchReward(String rewardId) {
    final request = RewardRequest(rewardId: rewardId);
    return _client.findReward(request);
  }

  Future<RewardResponse> updateRewardSpeech(
    String rewardId,
    Speech speech,
  ) {
    final request = RewardSpeechRequest(rewardId: rewardId, speech: speech);
    return _client.updateRewardSpeech(request);
  }

  Future<RewardResponse> addRewardAssets(
    Stream<AddRewardAssetRequest> stream,
  ) {
    return _client.addRewardAssets(stream);
  }

  Future<void> updateRewardAssets(
    String rewardId,
    String fileName,
    int volume,
  ) async {
    final request = UpdateRewardAssetRequest(
      rewardId: rewardId,
      fileName: fileName,
      volume: volume,
    );
    await _client.updateRewardAssets(request);
  }

  ResponseFuture<RewardResponse> deleteRewardAsset(
    String rewardId,
    String fileName,
  ) {
    final request = RemoveRewardAssetRequest(rewardId: rewardId);
    request.fileName.add(fileName);
    return _client.removeRewardAssets(request);
  }
}
