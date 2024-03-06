import 'package:flutter/material.dart';
import 'package:stream_droid_app/layout/base_view.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';
import 'package:stream_droid_app/utils/view_destination.dart';

class MediaView extends StatelessWidget with BaseView {
  const MediaView({super.key});

  @override
  ViewDestination get view => ViewDestination.media;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      baseView: this,
      child: Container(),
    );
  }
}
