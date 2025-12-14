import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/data/models/api_state.dart';
import 'package:stream_droid_app/domain/generated/common/reward.pb.dart';
import 'package:stream_droid_app/domain/generated/service/rewardservice.pb.dart';
import 'package:stream_droid_app/domain/services/reward_service.dart';

class RewardCardViewModel extends ChangeNotifier {
  RewardCardViewModel(this._rewardId, Speech? _speech) {
    final rewardSpeech = _speech ?? Speech(enabled: false);
    state = ApiState.success(rewardSpeech);
    _rewardService = DependencyManager.getIt<RewardService>();
  }
  final String _rewardId;
  late RewardService _rewardService;
  ResponseFuture<RewardResponse>? _request;
  late ApiState<Speech> state;

  Future<void> toggleTextToSpeech(bool value) async {
    final rewardSpeech = Speech(enabled: value);

    try {
      _request = _rewardService.updateRewardSpeech(_rewardId, rewardSpeech);
      final response = await _request;
      state = ApiState.success(response!.reward.speech);
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
