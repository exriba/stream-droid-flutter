import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/dashboard/dashboard_view.dart';
import 'package:stream_droid_app/layout/app_view.dart';
import 'package:stream_droid_app/layout/base_view.dart';
import 'package:stream_droid_app/media/media_view.dart';
import 'package:stream_droid_app/setting/settings_view.dart';
import 'package:stream_droid_app/statistic/statistics_view.dart';
import 'package:stream_droid_app/utils/string_util.dart';
import 'package:stream_droid_app/utils/view_destination.dart';

class _NavigationItem {
  final IconData icon;
  final Widget destination;

  const _NavigationItem({
    required this.icon,
    required this.destination,
  });
}

const List<_NavigationItem> _navigationItems = [
  _NavigationItem(
    icon: Icons.dashboard,
    destination: DashboardView(),
  ),
  _NavigationItem(
    icon: Icons.show_chart,
    destination: StatisticsView(),
  ),
  _NavigationItem(
    icon: Icons.play_circle_fill,
    destination: MediaView(),
  ),
  _NavigationItem(
    icon: Icons.settings,
    destination: SettingsView(),
  ),
];

final class NavigationView extends StatelessWidget {
  const NavigationView(
      {super.key, required this.baseView, required this.child});
  final BaseView baseView;
  final Widget child;

  void navigateToView(BuildContext context, int value) {
    final item = _navigationItems[value];
    final destination = ViewDestination.values[value].name;
    final currentRouteName = ModalRoute.of(context)?.settings.name;
    if (currentRouteName == null && value != ViewDestination.dashboard.index ||
        currentRouteName != destination) {
      Navigator.push(
        context,
        PageRouteBuilder(
          settings: RouteSettings(
            name: destination,
          ),
          pageBuilder: (context, animation1, animation2) {
            return item.destination;
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
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
                    selectedIndex: baseView.view.index,
                    indicatorColor: Colors.grey,
                    backgroundColor: Colors.transparent,
                    destinations: _navigationItems
                        .map(
                          (item) => NavigationRailDestination(
                            padding: const EdgeInsets.only(top: 30),
                            icon: Icon(item.icon),
                            label: Container(),
                          ),
                        )
                        .toList(),
                    onDestinationSelected: (value) {
                      navigateToView(context, value);
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
                        await userContext.onLogout(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(33, 33, 33, 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TO-DO: Convert to custom widget. Add Text animation
                    Flexible(
                      flex: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                            baseView.view.name.withCapitalizedFirstLetter(),
                            style: Theme.of(context).textTheme.bodyLarge,
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
              ),
            ),
          ],
        ),
      );
    });
  }
}
