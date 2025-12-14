import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/core/context/theme_context.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/presentation/viewmodels/login_view_model.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  Future<void> _handleLogin(
      LoginViewModel viewModel, BuildContext context) async {
    await viewModel.login();
    if (context.mounted && viewModel.state.data!.$2) {
      context.go(ViewRoute.dashboard.route);
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
            Consumer<LoginViewModel>(
              builder: (context, viewModel, child) {
                return SizedBox(
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
                      await _handleLogin(viewModel, context);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
