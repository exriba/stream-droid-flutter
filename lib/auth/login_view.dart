import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_droid_app/dashboard/dashboard_view.dart';
import 'package:stream_droid_app/layout/app_view.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/utils/view_destination.dart';
import 'package:window_manager/window_manager.dart';

final class LoginView extends StatelessWidget {
  const LoginView({super.key});

  Future<void> onLogin(BuildContext context, UserContext userContext) async {
    await windowManager.setOpacity(0);
    userContext.onLogin();

    if (!context.mounted) return;
    Navigator.push(
      context,
      PageRouteBuilder(
        settings: RouteSettings(
          name: ViewDestination.dashboard.name,
        ),
        pageBuilder: (context, animation1, animation2) {
          return const DashboardView();
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );

    const windowSize = Size(1280, 720);
    await windowManager.setSize(windowSize);
    await windowManager.center();
    await windowManager.setOpacity(1);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(builder: (context, userContext, child) {
      return AppView(
        child: Container(
          color: const Color.fromRGBO(33, 33, 33, 1),
          alignment: Alignment.center,
          child: SizedBox(
            height: 50,
            width: 150,
            child: TextButton.icon(
              style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shadowColor: Colors.black,
                  backgroundColor: Colors.purple[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              icon: SvgPicture.asset(
                'assets/twitch.svg',
                height: 30,
                width: 30,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              label: const Text(
                'Login',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                await onLogin(context, userContext);
              },
            ),
          ),
        ),
      );
    });
  }
}
