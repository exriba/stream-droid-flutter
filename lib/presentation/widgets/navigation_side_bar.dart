import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/core/context/theme_context.dart';
import 'package:stream_droid_app/domain/services/user_service.dart';

class NavigationSideBar extends StatelessWidget {
  const NavigationSideBar({super.key, required this.view});
  final Widget view;

  Future<void> handleLogout(BuildContext context) async {
    final userService = DependencyManager.getIt<UserService>();
    await userService.onLogout();

    if (context.mounted) {
      context.go(ViewRoute.login.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: ThemeContext.defaultNavigationColor,
          child: Column(
            spacing: 10,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: IconButton(
                  iconSize: 36,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.dashboard),
                  onPressed: () {
                    context.go(ViewRoute.dashboard.route);
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: IconButton(
                  iconSize: 36,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.play_circle_fill),
                  onPressed: () {
                    context.go(ViewRoute.media.route);
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: IconButton(
                  iconSize: 36,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.show_chart),
                  onPressed: () {
                    context.go(ViewRoute.statistics.route);
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: IconButton(
                  iconSize: 36,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    context.go(ViewRoute.settings.route);
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: IconButton(
                  iconSize: 36,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    await handleLogout(context);
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Consumer<ThemeContext>(
            builder: (context, themeContext, child) {
              return Scaffold(
                backgroundColor: themeContext.backgroundColor,
                body: view,
              );
            },
          ),
        )
      ],
    );
  }
}
