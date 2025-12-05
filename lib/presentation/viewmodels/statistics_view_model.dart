import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/data/models/redeem_redemption.dart';
import 'package:stream_droid_app/domain/services/redeem_service.dart';

class StatisticsViewModel extends ChangeNotifier {
  StatisticsViewModel() {
    _redeemService = DependencyManager.getIt<RedeemService>();
  }
  late RedeemService _redeemService;

  List<RedeemRedemption> channelRedeemRedemptions = [];
  bool loading = false;

  Future<void> loadRedeemRedemptions() async {
    loading = true;
    notifyListeners();

    channelRedeemRedemptions = await _redeemService.fetchRedeemRedemptions();

    loading = false;
    notifyListeners();
  }
}
