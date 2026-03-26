import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/providers/auth_interceptor.dart';
import 'package:stream_droid_app/src/providers/client_channel.dart';
import 'package:stream_droid_app/src/providers/error_handler.dart';
import 'package:stream_droid_app/src/providers/error_interceptor.dart';
import 'package:stream_droid_app/src/services/reward_service.dart';

final rewardServiceProvider = Provider<RewardService>((ref) {
  final errorHandler = ref.read(errorHandlerProvider);
  final clientChannel = ref.read(clientChannelProvider);
  final authInterceptor = ref.read(authInterceptorProvider);
  final errorInterceptor = ref.read(errorInterceptorProvider);
  return RewardService(
    errorHandler,
    clientChannel,
    authInterceptor,
    errorInterceptor,
  );
});

final rewardNotificationProvider =
    AsyncNotifierProvider.autoDispose<RewardNotifier, List<Reward>>(
  RewardNotifier.new,
);

class RewardNotifier extends AutoDisposeAsyncNotifier<List<Reward>> {
  @override
  Future<List<Reward>> build() async {
    final service = ref.read(rewardServiceProvider);
    final errorHandler = ref.read(errorHandlerProvider);
    final responses = await service.fetchRewards().handleError((error) {
      errorHandler.handle(error);
      throw error;
    }).toList();
    return responses.map((response) => response.reward).toList();
  }
}
