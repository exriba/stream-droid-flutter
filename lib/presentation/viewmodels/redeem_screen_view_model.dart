import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/data/models/redeem.dart';
import 'package:stream_droid_app/domain/services/reward_service.dart';

class RedeemScreenViewModel extends ChangeNotifier {
  RedeemScreenViewModel(this.redeemId) {
    _rewardService = DependencyManager.getIt<RewardService>();
  }
  final String redeemId;
  late RewardService _rewardService;

  bool loading = false;
  Redeem? redeem;

  Future<void> loadRedeem() async {
    loading = true;
    notifyListeners();

    redeem = await _rewardService.fetchRedeem(redeemId);

    loading = false;
    notifyListeners();
  }
}
