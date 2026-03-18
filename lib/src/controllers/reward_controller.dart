import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/services/reward_service.dart';

class RewardController {
  RewardController(RewardService rewardService) : _service = rewardService;
  final RewardService _service;

  Future<bool> updateSpeech(String rewardId, bool enabled) async {
    final speech = Speech(enabled: enabled);
    final response = await _service.updateRewardSpeech(rewardId, speech);
    return response.reward.speech.enabled;
  }
}
