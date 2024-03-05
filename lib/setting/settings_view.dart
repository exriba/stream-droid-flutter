import 'package:flutter/material.dart';
import 'package:stream_droid_app/layout/base_view.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';
import 'package:stream_droid_app/utils/view_destination.dart';

class SettingsView extends StatelessWidget with BaseView {
  const SettingsView({super.key});

  @override
  ViewDestination get view => ViewDestination.settings;

  @override
  String get name => "Settings";

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      baseView: this,
      child: Container(),
    );
  }
}
