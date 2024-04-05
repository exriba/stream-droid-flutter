import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_droid_app/api/custom_http_client.dart';
import 'package:stream_droid_app/api/custom_http_server.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:url_launcher/url_launcher.dart';

final class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.userContext});
  final UserContext userContext;

  @override
  State<StatefulWidget> createState() => _LoginView();
}

final class _LoginView extends State<LoginView> {
  late ICustomHttpServer httpServer;
  late ICustomHttpClient httpClient;

  @override
  void initState() {
    super.initState();
    httpServer = DependencyManager.getIt.get<ICustomHttpServer>();
    httpClient = DependencyManager.getIt.get<ICustomHttpClient>();
    httpServer.initializeHttpServer(onData: ({required String value}) async {
      await widget.userContext.onLogin(value);
    });
  }

  Future<void> handleLogin() async {
    final redirectUrl = await httpClient.get(urlFragment: UrlFragment.meLogin);
    final authorizationUrl = Uri.parse(redirectUrl);
    if (await canLaunchUrl(authorizationUrl)) {
      await launchUrl(authorizationUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: const Color.fromRGBO(33, 33, 33, 1),
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
              onPressed: handleLogin,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    httpServer.dispose();
  }
}
