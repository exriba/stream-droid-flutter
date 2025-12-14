import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/data/models/api_state.dart';
import 'package:stream_droid_app/domain/generated/service/userservice.pbenum.dart';
import 'package:stream_droid_app/domain/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel() {
    _userService = DependencyManager.getIt<UserService>();
  }
  late UserService _userService;
  late ApiState<(Uri, bool)> state = ApiState.initial();

  Future<void> loadUrl() async {
    try {
      final authorizationUrl = await _userService.authorizationUrl();
      final authorizationUri = Uri.parse(authorizationUrl);
      if (await canLaunchUrl(authorizationUri)) {
        state = ApiState.success((authorizationUri, false));
        notifyListeners();
      }
    } on GrpcError catch (error) {
      state = ApiState.error(error);
      notifyListeners();
    }
  }

  Future<void> login() async {
    await launchUrl(state.data!.$1);

    try {
      final response = _userService.monitorAuthentication();

      await for (final update in response) {
        if (update.status == SessionStatus_Status.ERROR) {
          state = ApiState.error(
              Exception('Authentication error: ${update.message}'));
          notifyListeners();
          break;
        }

        if (update.status == SessionStatus_Status.AUTHORIZED) {
          await _userService.login(update);
          state = ApiState.success((state.data!.$1, true));
          notifyListeners();
          break;
        }
      }
    } on GrpcError catch (error) {
      state = ApiState.error(error);
      notifyListeners();
    }
  }
}
