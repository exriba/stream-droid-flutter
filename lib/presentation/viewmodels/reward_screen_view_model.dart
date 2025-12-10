import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/domain/generated/common/reward.pb.dart';
import 'package:stream_droid_app/domain/services/reward_service.dart';

class RewardScreenViewModel extends ChangeNotifier {
  RewardScreenViewModel(this.rewardId) {
    _rewardService = DependencyManager.getIt<RewardService>();
  }
  final String rewardId;
  late RewardService _rewardService;

  bool loading = false;
  Reward? reward;

  Future<void> loadReward() async {
    loading = true;
    notifyListeners();

    reward = await _rewardService.fetchReward(rewardId);

    loading = false;
    notifyListeners();
  }
}
