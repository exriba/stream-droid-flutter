import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/domain/generated/common/redeem.pb.dart';
import 'package:stream_droid_app/domain/services/redeem_service.dart';

class StatisticsViewModel extends ChangeNotifier {
  StatisticsViewModel() {
    _redeemService = DependencyManager.getIt<RedeemService>();
  }
  late RedeemService _redeemService;

  List<RewardRedeem> rewardRedeems = [];
  bool loading = false;

  Future<void> loadRewardRedeems() async {
    loading = true;
    notifyListeners();

    rewardRedeems = await _redeemService.fetchRewardRedeems();

    loading = false;
    notifyListeners();
  }
}
