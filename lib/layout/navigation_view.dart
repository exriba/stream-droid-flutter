import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/layout/app_view.dart';
import 'package:stream_droid_app/layout/base_view.dart';

class _NavigationItem {
  final String text;
  final IconData icon;
  final Future<void> Function() action;

  const _NavigationItem({
    required this.icon,
    required this.text,
    required this.action,
  });
}

final class NavigationView extends StatefulWidget {
  const NavigationView(
      {super.key, required this.baseView, required this.child});
  final BaseView baseView;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _NavigationView();
}

class _NavigationView extends State<NavigationView> {
  var selectedIndex = 0;

  // ignore: library_private_types_in_public_api
  final List<_NavigationItem> navigationItems = [
    _NavigationItem(
      icon: Icons.dashboard,
      text: 'Dashboard',
      action: () async {},
    ),
    _NavigationItem(
      icon: Icons.show_chart,
      text: 'Statistics',
      action: () async {},
    ),
    _NavigationItem(
      icon: Icons.play_circle_fill,
      text: 'Media',
      action: () async {},
    ),
    _NavigationItem(
      icon: Icons.settings,
      text: 'Settings',
      action: () async {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(builder: (context, userContext, child) {
      print(context.widget.toStringShort());
      return AppView(
        child: Row(
          children: [
            Column(
              children: [
                Flexible(
                  flex: 9,
                  child: NavigationRail(
                    extended: false,
                    selectedIndex: selectedIndex,
                    indicatorColor: Colors.grey,
                    backgroundColor: Colors.transparent,
                    destinations: navigationItems
                        .map(
                          (item) => NavigationRailDestination(
                            padding: const EdgeInsets.only(top: 30),
                            icon: Icon(item.icon),
                            label: Text(item.text,
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color.fromRGBO(33, 33, 33, 1),
                                      letterSpacing: 1),
                                )),
                          ),
                        )
                        .toList(),
                    onDestinationSelected: (value) => setState(() {
                      selectedIndex = value;
                    }),
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
                      onTap: () async => await userContext.onLogout(),
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
                          child: Text(widget.baseView.name,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color.fromRGBO(33, 33, 33, 1),
                                    letterSpacing: 1),
                              )),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: widget.child,
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
