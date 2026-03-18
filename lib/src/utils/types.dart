import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ContextCallback = void Function(BuildContext context, WidgetRef ref);

enum ViewRoute {
  dashboard('/'),
  rewards('/rewards/:id'),
  media('/media'),
  statistics('/statistics'),
  settings('/settings'),
  login('/login');

  const ViewRoute(this.route);
  final String route;
}
