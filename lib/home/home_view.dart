import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:window_manager/window_manager.dart';
import 'package:stream_droid_app/auth/login_view.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/layout/loading_view.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  final maximumSize = const Size(1280, 720);
  final minimumSize = const Size(900, 600);

  Future<bool> _verifyUserAuthentication(UserContext userContext) async {
    try {
      final authenticated = await userContext.isAuthenticated();
      final size = authenticated ? maximumSize : minimumSize;
      await windowManager.setSize(size);
      return authenticated;
    } catch (exception) {
      await windowManager.setSize(minimumSize);
      rethrow;
    } finally {
      await windowManager.center();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(builder: (context, userContext, child) {
      return FutureBuilder<bool>(
          future: _verifyUserAuthentication(userContext),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                final message = (snapshot.error is ClientException)
                    ? 'Unable to reach backend server'
                    : 'An error ocurred';
                toastification.show(
                    context: context,
                    title: Text(message),
                    type: ToastificationType.error,
                    primaryColor: Colors.black,
                    backgroundColor: Colors.red,
                    autoCloseDuration: const Duration(seconds: 3));
              });
              return LoginView(userContext: userContext);
            }

            if (snapshot.hasData) {
              return snapshot.data == true
                  ? const NavigationView()
                  : LoginView(userContext: userContext);
            }

            return const LoadingView();
          });
    });
  }
}
