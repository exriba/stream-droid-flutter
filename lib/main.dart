import 'package:flutter/material.dart';
import 'package:stream_droid_app/app.dart';
import 'package:window_manager/window_manager.dart';

const windowOptions = WindowOptions(
    center: true,
    size: Size(600, 600),
    minimumSize: Size(600, 600),
    titleBarStyle: TitleBarStyle.hidden);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
  });

  runApp(const App());
}
