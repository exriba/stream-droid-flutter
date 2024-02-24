import 'package:flutter/material.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationView(
        child: Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(33, 33, 33, 1),
      ),
    ));
  }
}
