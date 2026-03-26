import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/generated/common/redeem.pb.dart';
import 'package:stream_droid_app/src/providers/auth_interceptor.dart';
import 'package:stream_droid_app/src/providers/client_channel.dart';
import 'package:stream_droid_app/src/providers/error_interceptor.dart';
import 'package:stream_droid_app/src/services/redeem_service.dart';

final redeemServiceProvider = Provider<RedeemService>((ref) {
  final clientChannel = ref.read(clientChannelProvider);
  final authInterceptor = ref.read(authInterceptorProvider);
  final errorInterceptor = ref.read(errorInterceptorProvider);
  return RedeemService(clientChannel, authInterceptor, errorInterceptor);
});

final redeemNotificationProvider =
    AsyncNotifierProvider.autoDispose<RedeemNotifier, List<RewardRedeem>>(
  RedeemNotifier.new,
);

class RedeemNotifier extends AutoDisposeAsyncNotifier<List<RewardRedeem>> {
  @override
  Future<List<RewardRedeem>> build() async {
    final service = ref.read(redeemServiceProvider);
    final response = await service.fetchRewardRedeems();
    return response.rewardRedeems;
  }
}
