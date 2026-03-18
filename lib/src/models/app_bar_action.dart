import 'package:flutter/material.dart';
import 'package:stream_droid_app/src/utils/types.dart';

class AppBarAction {
  const AppBarAction({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final ContextCallback onPressed;
}
