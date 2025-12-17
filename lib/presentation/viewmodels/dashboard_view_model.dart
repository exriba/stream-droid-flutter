import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/data/models/api_state.dart';
import 'package:stream_droid_app/domain/generated/common/reward.pb.dart';
import 'package:stream_droid_app/domain/generated/service/rewardservice.pb.dart';
import 'package:stream_droid_app/domain/services/reward_service.dart';
import 'package:stream_droid_app/presentation/viewmodels/base_view_model.dart';

class DashboardViewModel extends BaseViewModel {
  DashboardViewModel() {
    _rewardService = DependencyManager.getIt<RewardService>();
  }
  late RewardService _rewardService;
  ResponseStream<RewardResponse>? _request;
  late ApiState<List<Reward>> state = ApiState.initial();

  Future<void> loadRewards() async {
    final List<Reward> rewards = [];
    state = ApiState.loading();
    notifyListeners();

    try {
      _request = _rewardService.fetchRewards();
      await for (final response in _request!) {
        rewards.add(response.reward);
      }
      state = ApiState.success(rewards);
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
