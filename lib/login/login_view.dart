import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/api/custom_http_client.dart';
import 'package:stream_droid_app/util/droid_server.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/context/theme_context.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  Future<void> _handleLogin(BuildContext context) async {
    final userContext = context.read<UserContext>();
    final httpClient = DependencyManager.getIt.get<ICustomHttpClient>();
    final authUri = await httpClient.get(urlFragment: UrlFragment.meLogin);
    final authUrl = Uri.parse(authUri);
    if (await canLaunchUrl(authUrl)) {
      final httpServer = DroidServer();
      await launchUrl(authUrl);
      httpServer.initializeServer(callback: (cookie, token) async {
        if (cookie != null) {
          await userContext.onLogin(cookie.value);
        }
        if (context.mounted) {
          context.go(ViewRoute.dashboard.route);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = context.read<ThemeContext>();

    return Scaffold(
      backgroundColor: themeContext.backgroundColor,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/images/app-icon.png",
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
                  'assets/images/twitch.svg',
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
                  await _handleLogin(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
