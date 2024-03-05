import 'package:flutter/material.dart';

class UserContext extends ChangeNotifier {
  var authenticated = false;

  void onLogin() {
    authenticated = true;
    notifyListeners();
  }

  void onLogout() {
    authenticated = false;
    notifyListeners();
  }
}
