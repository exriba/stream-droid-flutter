import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/data/models/redeem.dart';
import 'package:stream_droid_app/domain/services/redeem_service.dart';

class RedeemScreenViewModel extends ChangeNotifier {
  RedeemScreenViewModel(this.redeemId) {
    _redeemService = DependencyManager.getIt<RedeemService>();
  }
  final String redeemId;
  late RedeemService _redeemService;

  bool loading = false;
  Redeem? redeem;

  Future<void> loadRedeem() async {
    loading = true;
    notifyListeners();

    redeem = await _redeemService.fetchRedeem(redeemId);

    loading = false;
    notifyListeners();
  }
}
