import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/domain/generated/common/reward.pb.dart';
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
    loading = true;
    notifyListeners();

    final assets =
        await _rewardService.addRewardAssets(_rewardId, _defaultVolume.toInt());
    if (assets.isNotEmpty) {
      rewardAssets = assets;
    }

    loading = false;
    notifyListeners();
  }

  Future<void> removeRewardAsset(String fileName) async {
    loading = true;
    notifyListeners();

    rewardAssets = await _rewardService.deleteRewardAsset(_rewardId, fileName);

    loading = false;
    notifyListeners();
  }
}
