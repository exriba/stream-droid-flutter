import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/generated/google/protobuf/empty.pb.dart';
import 'package:stream_droid_app/src/generated/service/rewardservice.pbgrpc.dart';
import 'package:stream_droid_app/src/interceptors/auth_interceptor.dart';
import 'package:stream_droid_app/src/interceptors/error_interceptor.dart';
import 'package:stream_droid_app/src/utils/error_handler.dart';

class RewardService {
  RewardService(
    ErrorHandler errorHandler,
    ClientChannel channel,
    AuthInterceptor authInterceptor,
    ErrorInterceptor errorInterceptor,
  )   : _errorHandler = errorHandler,
        _client = GrpcRewardServiceClient(
          channel,
          interceptors: [authInterceptor, errorInterceptor],
        );

  final ErrorHandler _errorHandler;
  final GrpcRewardServiceClient _client;

  Stream<RewardResponse> fetchRewards() {
    return _client.findUserRewards(Empty());
  }

  Future<bool> updateRewardSpeech(String rewardId, bool enabled) async {
    final speech = Speech(enabled: enabled);
    final request = RewardSpeechRequest(rewardId: rewardId, speech: speech);

    try {
      final response = await _client.updateRewardSpeech(request);
      return response.reward.speech.enabled;
    } on GrpcError {
      return !enabled;
    }
  }

  Future<List<Asset>> addRewardAssets(String rewardId, int volume) async {
    final assets = <Asset>[];
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4'],
      allowMultiple: true,
      withData: true,
    );

    if (result == null) {
      return assets;
    }

    const int maxTotalSizeBytes = 25 * 1024 * 1024;
    final fileSize = result.files.fold(0, (sum, file) => sum + file.size);

    if (fileSize > maxTotalSizeBytes) {
      throw Exception('Total file size exceeds the maximum limit of 25 MB.');
    }

    final requests = result.files.map((file) {
      return AddRewardAssetRequest(
        rewardId: rewardId,
        fileName: file.name,
        volume: volume,
        file: file.bytes,
      );
    }).toList();

    try {
      final response = await _client.addRewardAssets(
        Stream.fromIterable(requests),
      );
      return response.reward.assets;
    } on GrpcError catch (error) {
      _errorHandler.handle(error);
      return assets;
    }
  }

  Future<void> updateRewardAsset(
    String rewardId,
    String fileName,
    int volume,
  ) async {
    final request = UpdateRewardAssetRequest(
      rewardId: rewardId,
      fileName: fileName,
      volume: volume,
    );
    try {
      await _client.updateRewardAssets(request);
    } on GrpcError {
      return;
    }
  }

  Future<List<Asset>> deleteRewardAsset(
    String rewardId,
    String fileName,
  ) async {
    final request = RemoveRewardAssetRequest(
      rewardId: rewardId,
      fileName: [fileName],
    );
    final response = await _client.removeRewardAssets(request);
    return response.reward.assets;
  }
}
