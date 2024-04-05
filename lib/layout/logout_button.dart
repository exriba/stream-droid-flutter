import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/app.dart';
import 'package:stream_droid_app/context/user_context.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  void _handleLogout(BuildContext context, UserContext userContext) {
    userContext.onLogout().whenComplete(() async {
      await Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return const App();
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(
      builder: (context, userContext, child) {
        return SizedBox(
          height: 32,
          width: 56,
          child: InkWell(
            hoverColor: Colors.transparent,
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.logout),
            onTap: () {
              _handleLogout(context, userContext);
            },
          ),
        );
      },
    );
  }
}
