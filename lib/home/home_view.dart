import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/auth/login_view.dart';
import 'package:stream_droid_app/dashboard/dashboard_view.dart';
import 'package:stream_droid_app/context/user_context.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<bool> _verifyUserAuthentication(UserContext userContext) async {
    return await userContext.isAuthenticated();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(builder: (context, userContext, child) {
      return FutureBuilder<bool>(
          future: _verifyUserAuthentication(userContext),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data == true) {
              return const DashboardView();
            }

            return LoginView(userContext: userContext);
          });
    });
  }
}
