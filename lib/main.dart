import 'dart:ui';
import 'dart:async';
import 'package:localstorage/localstorage.dart';
import 'package:talker/talker.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:stream_droid_app/app.dart';
import 'package:window_manager/window_manager.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';

// TODO: Review app views and implement responsive design where necessary.
const windowOptions = WindowOptions(
    center: true,
    title: "Stream Droid",
    size: Size(900, 600),
    minimumSize: Size(900, 600));

Future<void> main() async {
  FutureBuilder.debugRethrowError = true;
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  DependencyManager.configure();
  PlatformDispatcher.instance.onError = onError;

  await initLocalStorage();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const App());
}

// TODO: logs
Talker? talker;
bool onError(Object error, StackTrace stack) {
  talker = talker ?? Talker();
  talker?.handle(error, stack);
  return true;
}
