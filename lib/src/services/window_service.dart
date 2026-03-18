import 'dart:async';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

class WindowService {
  static Future<void> ensureInitialized() async {
    await windowManager.ensureInitialized();
    const defaultSize = Size(1000, 600);

    const WindowOptions options = WindowOptions(
      size: defaultSize,
      minimumSize: defaultSize,
      center: true,
      title: constants.appName,
    );

    await windowManager.hide();

    windowManager.waitUntilReadyToShow(options, () async {
      await windowManager.show();
      await windowManager.focus();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        const tempSize = Size(1001, 601);
        await windowManager.setSize(tempSize);
        await windowManager.setSize(defaultSize);
      });
    });
  }

  static Future<void> setTitle(String title) async {
    await windowManager.setTitle(title);
  }

  static Future<void> resize(double width, double height) async {
    await windowManager.setSize(Size(width, height));
  }

  static Future<void> maximize() async {
    await windowManager.maximize();
  }

  static Future<void> fullscreen() async {
    await windowManager.setFullScreen(true);
  }
}
