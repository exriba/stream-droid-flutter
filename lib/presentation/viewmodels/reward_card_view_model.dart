import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/domain/generated/common/reward.pb.dart';
import 'package:stream_droid_app/domain/services/reward_service.dart';

class RewardCardViewModel extends ChangeNotifier {
  RewardCardViewModel(this._rewardId, Speech? _speech) {
    speech = _speech ?? Speech(enabled: false);
    _rewardService = DependencyManager.getIt<RewardService>();
  }
  final String _rewardId;
  late RewardService _rewardService;
  late Speech speech;

  Future<void> toggleTextToSpeech(bool value) async {
    final rewardSpeech = Speech(enabled: value);
    speech = await _rewardService.updateRewardSpeech(_rewardId, rewardSpeech);
    notifyListeners();
  }
}
