import 'package:flutter/material.dart';
import 'package:stream_droid_app/layout/custom_app_bar.dart';

final class BaseView extends StatelessWidget {
  final Widget child;

  const BaseView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: CustomAppBar(),
      body: Container(
        margin: const EdgeInsets.only(left: 2, right: 2, bottom: 2),
        child: child,
      ),
    );
  }
}
