import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/domain/generated/common/reward.pb.dart';
import 'package:stream_droid_app/domain/generated/service/rewardservice.pb.dart';
import 'package:stream_droid_app/domain/services/reward_service.dart';

class RewardCardAssetListViewModel extends ChangeNotifier {
  RewardCardAssetListViewModel(this._rewardId, this._defaultVolume) {
    _rewardService = DependencyManager.getIt.get<RewardService>();
  }
  final String _rewardId;
  final double _defaultVolume;
  late RewardService _rewardService;

  List<Asset> rewardAssets = [];
  bool loading = false;

  Future<void> loadRewardAssets() async {
    loading = true;
    notifyListeners();

    rewardAssets = await _rewardService.fetchRewardAssets(_rewardId);

    loading = false;
    notifyListeners();
  }

  Future<void> addRewardAssets() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4'],
      allowMultiple: true,
    );

    if (result != null) {
      loading = true;
      notifyListeners();

      List<AddRewardAssetRequest> requests = [];

      for (final path in result.paths) {
        final file = File(path!);
        final bytes = await file.readAsBytes();
        final request = AddRewardAssetRequest(
          rewardId: _rewardId,
          fileName: path,
          volume: _defaultVolume.toInt(),
          file: bytes,
        );
        requests.add(request);
      }

      Stream<AddRewardAssetRequest> request = Stream.fromIterable(requests);
      rewardAssets = await _rewardService.addRewardAssets(request);

      loading = false;
      notifyListeners();
    }
  }

  Future<void> removeRewardAsset(String fileName) async {
    loading = true;
    notifyListeners();

    rewardAssets = await _rewardService.deleteRewardAsset(_rewardId, fileName);

    loading = false;
    notifyListeners();
  }
}
