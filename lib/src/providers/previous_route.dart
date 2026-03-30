import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/utils/types.dart';

final previousRouteProvider = StateProvider<String>((ref) {
  return ViewRoute.root.route;
});
