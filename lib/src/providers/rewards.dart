import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/controllers/reward_controller.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/providers/auth_interceptor.dart';
import 'package:stream_droid_app/src/providers/client_channel.dart';
import 'package:stream_droid_app/src/services/reward_service.dart';

part 'rewards.g.dart';

@Riverpod(keepAlive: true)
RewardService rewardService(RewardServiceRef ref) {
  final clientChannel = ref.read(clientChannelProvider);
  final authInterceptor = ref.read(authInterceptorProvider);
  return RewardService(clientChannel, authInterceptor);
}

@riverpod
RewardController rewardController(RewardControllerRef ref) {
  final rewardService = ref.read(rewardServiceProvider);
  return RewardController(rewardService);
}

@riverpod
class Rewards extends _$Rewards {
  @override
  Future<List<Reward>> build() async {
    final service = ref.read(rewardServiceProvider);
    final responses = await service.fetchRewards().toList();
    return responses.map((response) => response.reward).toList();
  }
}
