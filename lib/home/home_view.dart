import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/auth/login_view.dart';
import 'package:stream_droid_app/dashboard/dashboard_view.dart';
import 'package:stream_droid_app/context/user_context.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(builder: (context, userContext, child) {
      return userContext.authenticated
          ? const DashboardView()
          : const LoginView();
    });
  }
}
