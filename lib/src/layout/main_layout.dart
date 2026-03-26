import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_droid_app/src/models/app_bar_action.dart';
import 'package:stream_droid_app/src/providers/global_error.dart';
import 'package:stream_droid_app/src/providers/user.dart';
import 'package:stream_droid_app/src/utils/types.dart';

final List<AppBarAction> _appBarActions = [
  AppBarAction(
    icon: Icons.dashboard_outlined,
    onPressed: (context, ref) {
      context.go(ViewRoute.dashboard.route);
    },
  ),
  AppBarAction(
    icon: Icons.live_tv_outlined,
    onPressed: (context, ref) {
      context.go(ViewRoute.media.route);
    },
  ),
  AppBarAction(
    icon: Icons.show_chart_outlined,
    onPressed: (context, ref) {
      context.go(ViewRoute.statistics.route);
    },
  ),
  AppBarAction(
    icon: Icons.settings_outlined,
    onPressed: (context, ref) {
      context.go(ViewRoute.settings.route);
    },
  ),
  AppBarAction(
    icon: Icons.logout_outlined,
    onPressed: (context, ref) async {
      final service = ref.read(userServiceProvider);
      await service.logout();

      if (context.mounted) {
        context.go(ViewRoute.login.route);
      }
    },
  ),
];

class MainLayout extends ConsumerWidget {
  const MainLayout({super.key, required this.screen});
  final Widget screen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error = ref.watch(globalErrorProvider);

    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final scaffolMessenger = ScaffoldMessenger.of(context);
        if (scaffolMessenger.mounted) {
          scaffolMessenger.hideCurrentSnackBar();
        }
        scaffolMessenger.showSnackBar(
          SnackBar(
            content: Row(
              spacing: 10,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
                Expanded(
                  child: Text(
                    error,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            action: SnackBarAction(
              label: "Close",
              textColor: Colors.white,
              onPressed: () {
                scaffolMessenger.hideCurrentSnackBar();
              },
            ),
            duration: const Duration(
              days: 1,
            ),
          ),
        );
        final errorProvider = ref.read(globalErrorProvider.notifier);
        errorProvider.state = null;
      });
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Row(
          spacing: 2,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.purple[300],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black,
                    offset: Offset(-2, 2),
                  ),
                ],
              ),
              child: Column(
                spacing: 10,
                children: _appBarActions
                    .map(
                      (action) => Flexible(
                        fit: FlexFit.tight,
                        child: IconButton(
                          iconSize: 32,
                          icon: Icon(
                            action.icon,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            action.onPressed(context, ref);
                          },
                          style: IconButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Flexible(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(0, 4, 4, 4),
                child: screen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
