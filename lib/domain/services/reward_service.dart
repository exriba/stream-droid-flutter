import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:stream_droid_app/domain/generated/common/reward.pb.dart';
import 'package:stream_droid_app/domain/generated/google/protobuf/empty.pb.dart';
import 'package:stream_droid_app/domain/generated/service/rewardservice.pbgrpc.dart';
import 'package:stream_droid_app/domain/services/auth_interceptor.dart';

// TODO: handle errors for all these methods.
class RewardService {
  RewardService(ClientChannel channel, AuthInterceptor authInterceptor) {
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
      String rewardId, int defaultVolume) async {
    int totalFileSize = 0;
    final int maxTotalSizeBytes = 25 * 1024 * 1024;
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4'],
      allowMultiple: true,
      withData: true,
    );

    if (filePickerResult != null) {
      for (var file in filePickerResult.files) {
        totalFileSize += file.size;
      }

      if (totalFileSize > maxTotalSizeBytes) {
        return [];
        // throw Exception(
        //     'Total file size exceeds the maximum limit of 25 MB.');
      }

      final requestController = StreamController<AddRewardAssetRequest>();
      final future = _client.addRewardAssets(requestController.stream);

      for (final file in filePickerResult.files) {
        final request = AddRewardAssetRequest(
          rewardId: rewardId,
          fileName: file.name,
          volume: defaultVolume,
          file: file.bytes,
        );
        requestController.add(request);
      }
      requestController.close();

      final response = await future;
      return response.reward.assets;
    }

    return [];
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
