import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:stream_droid_app/app.dart';
import 'package:window_manager/window_manager.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  DependencyManager.configure();
  final userContext = UserContext();

  final authenticated = await userContext.isAuthenticated();
  const maximumSize = Size(1280, 720);
  const minimumSize = Size(600, 600);
  final windowOptions = WindowOptions(
      center: true,
      size: authenticated ? maximumSize : minimumSize,
      minimumSize: minimumSize,
      titleBarStyle: TitleBarStyle.hidden);

  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setTitle("Stream Droid");
    await windowManager.show();
  });

  runApp(App(
    userContext: userContext,
  ));
}
