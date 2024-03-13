import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_droid_app/layout/app_view.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:window_manager/window_manager.dart';

final class LoginView extends StatelessWidget {
  const LoginView({super.key});

  Future<void> handleLogin(UserContext userContext) async {
    await windowManager.setOpacity(0);
    userContext.onLogin();

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
          alignment: Alignment.center,
          color: const Color.fromRGBO(33, 33, 33, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/icons/app-icon.png",
                height: 128,
                width: 128,
              ),
              SizedBox(
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
                  label: Text(
                    'Login',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: () async {
                    await handleLogin(userContext);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
