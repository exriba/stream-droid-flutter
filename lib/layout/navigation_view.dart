import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/dashboard/dashboard_view.dart';
import 'package:stream_droid_app/layout/logout_button.dart';
import 'package:stream_droid_app/media/media_view.dart';
import 'package:stream_droid_app/setting/settings_view.dart';
import 'package:stream_droid_app/statistic/statistics_view.dart';

final class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationView();
}

const List<IconData> _navigationIcons = [
  Icons.dashboard,
  Icons.show_chart,
  Icons.play_circle_fill,
  Icons.settings,
];

class _NavigationView extends State<NavigationView> {
  Widget view = const SizedBox.shrink();
  ViewDestination viewDestination = ViewDestination.dashboard;

  @override
  void initState() {
    super.initState();
    view = const DashboardView();
  }

  void _navigateToView(int value) {
    final destination = ViewDestination.values[value];
    setState(() {
      viewDestination = destination;
      view = switch (destination) {
        ViewDestination.dashboard => const DashboardView(),
        ViewDestination.statistics => const StatisticsView(),
        ViewDestination.media => MediaView(key: UniqueKey()),
        ViewDestination.settings => const SettingsView(),
        _ => throw UnimplementedError(),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(builder: (context, userContext, child) {
      return Row(
        children: [
          Container(
            color: Colors.grey[700],
            child: Column(
              children: [
                Flexible(
                  flex: 9,
                  child: NavigationRail(
                    extended: false,
                    selectedIndex: viewDestination.index,
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
                    onDestinationSelected: _navigateToView,
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: LogoutButton(),
                ),
              ],
            ),
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
                    // TODO: Convert to custom widget. Add Text animation
                    Flexible(
                      flex: 0,
                      child: Container(
                        width: constraints.maxWidth / 2,
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
                            viewDestination.label,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: view,
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    view = const SizedBox.shrink();
  }
}
