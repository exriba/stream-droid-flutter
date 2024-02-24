import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class UserContext extends ChangeNotifier {
  var authenticated = false;

  Future<void> onLogin() async {
    await windowManager.setOpacity(0);
    authenticated = true;
    notifyListeners();

    const windowSize = Size(1280, 720);
    await windowManager.setSize(windowSize);
    await windowManager.center();
    await windowManager.setOpacity(1);
  }

  Future<void> onLogout() async {
    await windowManager.setOpacity(0);
    authenticated = false;
    notifyListeners();

    const windowSize = Size(500, 500);
    await windowManager.setSize(windowSize);
    await windowManager.center();
    await windowManager.setOpacity(1);
  }
}
