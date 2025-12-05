import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/data/models/redeem.dart';
import 'package:stream_droid_app/domain/services/redeem_service.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel() {
    _redeemService = DependencyManager.getIt<RedeemService>();
  }
  late RedeemService _redeemService;

  List<Redeem> channelRedeems = [];
  bool loading = false;

  Future<void> loadRedeems() async {
    loading = true;
    notifyListeners();

    channelRedeems = await _redeemService.fetchRedeems();

    loading = false;
    notifyListeners();
  }
}
