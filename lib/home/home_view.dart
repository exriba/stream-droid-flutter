import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/layout/loading_view.dart';
import 'package:window_manager/window_manager.dart';
import 'package:stream_droid_app/auth/login_view.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/dashboard/dashboard_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  final maximumSize = const Size(1280, 720);
  final minimumSize = const Size(900, 600);

  Future<bool> _verifyUserAuthentication(UserContext userContext) async {
    final authenticated = await userContext.isAuthenticated();
    final size = authenticated ? maximumSize : minimumSize;
    await windowManager.setSize(size);
    await windowManager.center();
    return authenticated;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(builder: (context, userContext, child) {
      return FutureBuilder<bool>(
          future: _verifyUserAuthentication(userContext),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const LoadingView();
            }

            return snapshot.data == true
                ? const DashboardView()
                : LoginView(userContext: userContext);
          });
    });
  }
}
