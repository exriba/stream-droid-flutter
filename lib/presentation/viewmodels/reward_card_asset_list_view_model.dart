import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/data/models/api_state.dart';
import 'package:stream_droid_app/domain/generated/common/reward.pb.dart';
import 'package:stream_droid_app/domain/generated/service/rewardservice.pb.dart';
import 'package:stream_droid_app/domain/services/reward_service.dart';
import 'package:stream_droid_app/presentation/viewmodels/base_view_model.dart';

class RewardCardAssetListViewModel extends BaseViewModel {
  RewardCardAssetListViewModel(this._rewardId, this._defaultVolume) {
    _rewardService = DependencyManager.getIt.get<RewardService>();
  }
  final String _rewardId;
  final double _defaultVolume;
  late RewardService _rewardService;
  ResponseFuture<RewardResponse>? _request;
  late ApiState<List<Asset>> state = ApiState.initial();

  Future<void> loadRewardAssets() async {
    state = ApiState.loading();
    notifyListeners();

    try {
      _request = _rewardService.fetchRewardAssets(_rewardId);
      final response = await _request;
      state = ApiState.success(response!.reward.assets);
      notifyListeners();
    } on GrpcError catch (error) {
      state = ApiState.error(error);
      if (!super.disposed) {
        notifyListeners();
      }
    }
  }

  Future<void> addRewardAssets() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4'],
      allowMultiple: true,
      withData: true,
    );

    if (filePickerResult != null) {
      final totalFileSize =
          filePickerResult.files.fold(0, (sum, file) => sum + file.size);
      final int maxTotalSizeBytes = 25 * 1024 * 1024;

      if (totalFileSize > maxTotalSizeBytes) {
        state = ApiState.error(const GrpcError.resourceExhausted(
            'Total file size exceeds the maximum limit of 25 MB.'));
        notifyListeners();
      } else {
        state = ApiState.loading();
        notifyListeners();

        final requestController = StreamController<AddRewardAssetRequest>();

        try {
          _request = _rewardService.addRewardAssets(requestController.stream);
          for (final file in filePickerResult.files) {
            final request = AddRewardAssetRequest(
              rewardId: _rewardId,
              fileName: file.name,
              volume: _defaultVolume.toInt(),
              file: file.bytes,
            );
            requestController.add(request);
          }
          await requestController.close();
          final response = await _request;
          state = ApiState.success(response!.reward.assets);
          notifyListeners();
        } on GrpcError catch (error) {
          state = ApiState.error(error);
          if (!super.disposed) {
            notifyListeners();
          }
        } on Exception catch (error) {
          requestController.addError(error);
        } finally {
          if (!requestController.isClosed) {
            await requestController.close();
          }
        }
      }
    }
  }

  Future<void> removeRewardAsset(String fileName) async {
    state = ApiState.loading();
    notifyListeners();

    try {
      _request = _rewardService.deleteRewardAsset(_rewardId, fileName);
      final response = await _request;
      state = ApiState.success(response!.reward.assets);
      notifyListeners();
    } on GrpcError catch (error) {
      state = ApiState.error(error);
      if (!super.disposed) {
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _request?.cancel();
    _request = null;
    super.dispose();
  }
}
