import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/generated/service/redeemservice.pbgrpc.dart';
import 'package:stream_droid_app/src/providers/auth_interceptor.dart';
import 'package:stream_droid_app/src/providers/client_channel.dart';
import 'package:stream_droid_app/src/services/redeem_service.dart';

final redeemServiceProvider = Provider<RedeemService>((ref) {
  final clientChannel = ref.read(clientChannelProvider);
  final authInterceptor = ref.read(authInterceptorProvider);
  return RedeemService(clientChannel, authInterceptor);
});

final redeemNotificationProvider =
    AsyncNotifierProvider.autoDispose<RedeemNotifier, RewardRedeemResponse>(
  RedeemNotifier.new,
);

class RedeemNotifier extends AutoDisposeAsyncNotifier<RewardRedeemResponse> {
  @override
  Future<RewardRedeemResponse> build() {
    final service = ref.read(redeemServiceProvider);
    return service.fetchRewardRedeems();
  }
}
