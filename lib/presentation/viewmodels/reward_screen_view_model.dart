import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/data/models/api_state.dart';
import 'package:stream_droid_app/domain/generated/common/reward.pb.dart';
import 'package:stream_droid_app/domain/generated/service/rewardservice.pb.dart';
import 'package:stream_droid_app/domain/services/reward_service.dart';
import 'package:stream_droid_app/presentation/viewmodels/base_view_model.dart';

class RewardScreenViewModel extends BaseViewModel {
  RewardScreenViewModel(this.rewardId) {
    _rewardService = DependencyManager.getIt<RewardService>();
  }
  final String rewardId;
  late RewardService _rewardService;
  ResponseFuture<RewardResponse>? _request;
  late ApiState<Reward> state = ApiState.initial();

  Future<void> loadReward() async {
    state = ApiState.loading();
    notifyListeners();

    try {
      _request = _rewardService.fetchReward(rewardId);
      final response = await _request;
      state = ApiState.success(response!.reward);
      notifyListeners();
    } on GrpcError catch (error) {
      state = ApiState.error(error);
      if (!super.disposed) {
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _request?.cancel();
    _request = null;
    super.dispose();
  }
}
