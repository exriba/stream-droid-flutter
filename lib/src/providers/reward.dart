import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/generated/service/rewardservice.pbgrpc.dart';
import 'package:stream_droid_app/src/providers/rewards.dart';

part 'reward.g.dart';

@riverpod
class Reward extends _$Reward {
  @override
  Future<RewardResponse> build(String rewardId) async {
    final service = ref.read(rewardServiceProvider);
    return service.fetchReward(rewardId);
  }
}
