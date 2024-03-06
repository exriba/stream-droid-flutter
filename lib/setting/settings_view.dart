import 'package:flutter/material.dart';
import 'package:stream_droid_app/layout/base_view.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';
import 'package:stream_droid_app/utils/view_destination.dart';

class SettingsView extends StatelessWidget with BaseView {
  const SettingsView({super.key});

  @override
  ViewDestination get view => ViewDestination.settings;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      baseView: this,
      child: Container(
        height: 64,
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Media',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Default asset volume',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
