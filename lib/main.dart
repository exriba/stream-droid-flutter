import 'package:flutter/material.dart';
import 'package:stream_droid_app/app.dart';
import 'package:window_manager/window_manager.dart';

const windowOptions = WindowOptions(
    center: true,
    size: Size(500, 500),
    minimumSize: Size(500, 500),
    titleBarStyle: TitleBarStyle.hidden);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
  });

  runApp(const App());
}
