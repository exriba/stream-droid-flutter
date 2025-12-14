import 'package:grpc/grpc.dart';
import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/data/models/api_state.dart';
import 'package:stream_droid_app/domain/generated/common/redeem.pb.dart';
import 'package:stream_droid_app/domain/generated/service/redeemservice.pb.dart';
import 'package:stream_droid_app/domain/services/redeem_service.dart';

class StatisticsViewModel extends ChangeNotifier {
  StatisticsViewModel() {
    _redeemService = DependencyManager.getIt<RedeemService>();
  }
  late RedeemService _redeemService;
  ResponseFuture<RewardRedeemResponse>? _request;
  late ApiState<List<RewardRedeem>> state = ApiState.initial();

  Future<void> loadRewardRedeems() async {
    state = ApiState.loading();
    notifyListeners();

    try {
      _request = _redeemService.fetchRewardRedeems();
      final response = await _request;
      state = ApiState.success(response!.rewardRedeems);
      notifyListeners();
    } on GrpcError catch (error) {
      state = ApiState.error(error);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _request?.cancel();
    _request = null;
    super.dispose();
  }
}
