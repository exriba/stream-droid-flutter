import 'dart:async';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:stream_droid_app/app.dart';
import 'package:window_manager/window_manager.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';

// TODO: Review app views and implement responsive design where necessary.
const windowOptions = WindowOptions(
    center: true,
    size: Size(900, 600),
    minimumSize: Size(900, 600),
    titleBarStyle: TitleBarStyle.hidden);

Future<void> main() async {
  await runZonedGuarded<Future<void>>(() async {
    FutureBuilder.debugRethrowError = true;
    WidgetsFlutterBinding.ensureInitialized();
    MediaKit.ensureInitialized();
    DependencyManager.configure();

    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setTitle("Stream Droid");
      await windowManager.show();
    });

    runApp(const App());
  }, (error, stack) {
    print(error);
    print(stack);
  });
}
