import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/data/models/redeem.dart';
import 'package:stream_droid_app/domain/services/reward_service.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel() {
    _rewardService = DependencyManager.getIt<RewardService>();
  }
  late RewardService _rewardService;

  List<Redeem> channelRedeems = [];
  bool loading = false;

  Future<void> loadRedeems() async {
    loading = true;
    notifyListeners();

    channelRedeems = await _rewardService.fetchRedeems();

    loading = false;
    notifyListeners();
  }
}
