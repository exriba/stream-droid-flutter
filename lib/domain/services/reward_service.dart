import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/domain/generated/common/reward.pb.dart';
import 'package:stream_droid_app/domain/generated/google/protobuf/empty.pb.dart';
import 'package:stream_droid_app/domain/generated/service/rewardservice.pbgrpc.dart';
import 'package:stream_droid_app/domain/services/auth_interceptor.dart';
import 'package:stream_droid_app/core/constants/constants.dart' as constants;

// TODO: handle errors for all these methods.
class RewardService {
  RewardService(AuthInterceptor authInterceptor) {
    final channel = ClientChannel(
      constants.serverName,
      port: constants.serverPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        // TODO: Use secure credentials for production
      ),
    );
    _client = GrpcRewardServiceClient(channel, interceptors: [authInterceptor]);
  }
  late GrpcRewardServiceClient _client;

  Future<List<Reward>> fetchRewards() async {
    final request = Empty();
    final List<Reward> rewards = [];
    final response = _client.findUserRewards(request);

    await for (final update in response) {
      rewards.add(update.reward);
    }

    return rewards;
  }

  Future<Reward> fetchReward(String rewardId) async {
    final request = RewardRequest(rewardId: rewardId);
    final response = await _client.findReward(request);
    return response.reward;
  }

  Future<Speech> updateRewardSpeech(String rewardId, Speech speech) async {
    final request = RewardSpeechRequest(rewardId: rewardId, speech: speech);
    final response = await _client.updateRewardSpeech(request);
    return response.reward.speech;
  }

  Future<List<Asset>> fetchRewardAssets(String rewardId) async {
    final reward = await fetchReward(rewardId);
    return reward.assets;
  }

  Future<List<Asset>> addRewardAssets(
      Stream<AddRewardAssetRequest> request) async {
    final response = await _client.addRewardAssets(request);
    return response.reward.assets;
  }

  Future<void> updateRewardAssets(
      String rewardId, String fileName, int volume) async {
    final request = UpdateRewardAssetRequest(
        rewardId: rewardId, fileName: fileName, volume: volume);
    await _client.updateRewardAssets(request);
  }

  Future<List<Asset>> deleteRewardAsset(
      String rewardId, String fileName) async {
    final request = RemoveRewardAssetRequest(rewardId: rewardId);
    request.fileName.add(fileName);
    final response = await _client.removeRewardAssets(request);
    return response.reward.assets;
  }
}
