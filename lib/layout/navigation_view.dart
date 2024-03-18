import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/dashboard/dashboard_view.dart';
import 'package:stream_droid_app/home/home_view.dart';
import 'package:stream_droid_app/layout/app_view.dart';
import 'package:stream_droid_app/media/media_view.dart';
import 'package:stream_droid_app/setting/settings_view.dart';
import 'package:stream_droid_app/statistic/statistics_view.dart';
import 'package:stream_droid_app/utils/string_util.dart';
import 'package:stream_droid_app/utils/view_destination.dart';
import 'package:window_manager/window_manager.dart';

final class NavigationView extends StatelessWidget {
  const NavigationView({super.key, this.viewDestination, required this.child});
  final ViewDestination? viewDestination;
  final Widget child;

  static final List<IconData> _navigationIcons = [
    Icons.dashboard,
    Icons.show_chart,
    Icons.play_circle_fill,
    Icons.settings,
  ];

  Future<void> navigateToView(BuildContext context, int value) async {
    final destination = ViewDestination.values[value];
    if (value != viewDestination!.index) {
      await Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          settings: RouteSettings(
            name: destination.name,
          ),
          pageBuilder: (context, animation1, animation2) {
            return switch (destination) {
              ViewDestination.dashboard => const DashboardView(),
              ViewDestination.statistics => const StatisticsView(),
              ViewDestination.media => MediaView(key: UniqueKey()),
              ViewDestination.settings => const SettingsView(),
              _ => throw UnimplementedError(),
            };
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  Future<void> handleLogout(
      BuildContext context, UserContext userContext) async {
    userContext.onLogout();

    await Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          const windowSize = Size(500, 500);
          final resizeWindow = windowManager.setSize(windowSize);
          final centerWindow = windowManager.center();
          Future.wait([resizeWindow, centerWindow]);
          return const HomeView();
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(builder: (context, userContext, child) {
      return AppView(
        child: Row(
          children: [
            Column(
              children: [
                Flexible(
                  flex: 9,
                  child: NavigationRail(
                    extended: false,
                    selectedIndex: viewDestination?.index,
                    indicatorColor: Colors.grey,
                    backgroundColor: Colors.transparent,
                    destinations: _navigationIcons
                        .map(
                          (item) => NavigationRailDestination(
                            padding: const EdgeInsets.only(top: 30),
                            icon: Icon(item),
                            label: const SizedBox.shrink(),
                          ),
                        )
                        .toList(),
                    onDestinationSelected: (value) async {
                      await navigateToView(context, value);
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 32,
                    width: 56,
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.logout),
                      onTap: () async {
                        await handleLogout(context, userContext);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: LayoutBuilder(builder: (context, constraints) {
                return Container(
                  height: constraints.maxHeight,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TO-DO: Convert to custom widget. Add Text animation
                      viewDestination == null
                          ? const SizedBox.shrink()
                          : Flexible(
                              flex: 0,
                              child: Container(
                                width: constraints.maxWidth / 2,
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    viewDestination!.name
                                        .withCapitalizedFirstLetter(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                      Flexible(
                        flex: 1,
                        child: this.child,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
