import 'package:flutter/material.dart';
import 'package:stream_droid_app/layout/base_view.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';

class StatisticsView extends StatelessWidget with BaseView {
  const StatisticsView({super.key});

  @override
  String get name => "Statistics";

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      baseView: this,
      child: Container(),
    );
  }
}
