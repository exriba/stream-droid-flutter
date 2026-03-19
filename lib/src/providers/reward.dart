import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/controllers/reward_controller.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/providers/auth_interceptor.dart';
import 'package:stream_droid_app/src/providers/client_channel.dart';
import 'package:stream_droid_app/src/services/reward_service.dart';

final rewardServiceProvider = Provider<RewardService>((ref) {
  final clientChannel = ref.read(clientChannelProvider);
  final authInterceptor = ref.read(authInterceptorProvider);
  return RewardService(clientChannel, authInterceptor);
});

final rewardControllerProvider = Provider<RewardController>((ref) {
  final rewardService = ref.read(rewardServiceProvider);
  return RewardController(rewardService);
});

final rewardNotificationProvider =
    AsyncNotifierProvider.autoDispose<RewardNotifier, List<Reward>>(
  RewardNotifier.new,
);

class RewardNotifier extends AutoDisposeAsyncNotifier<List<Reward>> {
  @override
  Future<List<Reward>> build() async {
    final service = ref.read(rewardServiceProvider);
    final responses = await service.fetchRewards().toList();
    return responses.map((response) => response.reward).toList();
  }
}
