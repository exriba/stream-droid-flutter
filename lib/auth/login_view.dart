import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_droid_app/layout/base_view.dart';
import 'package:stream_droid_app/context/user_context.dart';

final class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(builder: (context, userContext, child) {
      return BaseView(
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
                await userContext.onLogin();
              },
            ),
          ),
        ),
      );
    });
  }
}
