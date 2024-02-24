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


            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     pageBuilder: (BuildContext context,
            //         Animation<double> animation1,
            //         Animation<double> animation2) {
            //       return const DashboardView();
            //     },
            //     transitionDuration: Duration.zero,
            //     reverseTransitionDuration: Duration.zero,
            //   ),
            // )