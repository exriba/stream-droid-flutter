import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/providers/auth_interceptor.dart';
import 'package:stream_droid_app/src/providers/client_channel.dart';
import 'package:stream_droid_app/src/services/reward_service.dart';

part 'rewards.g.dart';

@riverpod
RewardService rewardService(RewardServiceRef ref) {
  final clientChannel = ref.read(clientChannelProvider);
  final authInterceptor = ref.read(authInterceptorProvider);
  return RewardService(clientChannel, authInterceptor);
}

@riverpod
class Rewards extends _$Rewards {
  @override
  Future<List<Reward>> build() async {
    final service = ref.read(rewardServiceProvider);
    final List<Reward> rewards = [];
    final stream = service.fetchRewards();
    await for (final response in stream) {
      rewards.add(response.reward);
    }
    return rewards;
  }
}
