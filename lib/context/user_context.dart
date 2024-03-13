import 'package:flutter/material.dart';

class UserContext extends ChangeNotifier {
  bool authenticated = false;
  double defaultMediaAssetVolume = 50.0;

  void updateDefaultMediaAssetVolume(double value) {
    defaultMediaAssetVolume = value;
    notifyListeners();
  }

  void onLogin() {
    authenticated = true;
    notifyListeners();
  }

  void onLogout() {
    authenticated = false;
    notifyListeners();
  }
}
