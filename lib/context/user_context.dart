import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stream_droid_app/api/custom_http_client.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';
import 'package:stream_droid_app/util/secure_storage.dart';
import 'package:stream_droid_app/common/constants.dart' as constants;

class UserContext extends ChangeNotifier {
  UserContext() {
    _secureStorage = DependencyManager.getIt.get<ISecureStorage>();
    _httpClient = DependencyManager.getIt.get<ICustomHttpClient>();
  }
  User _user = User.defaultUser();
  late ISecureStorage _secureStorage;
  late ICustomHttpClient _httpClient;

  double get defaultMediaAssetVolume {
    return _user.preferences.defaultVolume.toDouble();
  }

  void _setUser({String? id, String? name, Preferences? preferences}) {
    _user = User(
      id: id ?? _user.id,
      name: name ?? _user.name,
      preferences: preferences ?? _user.preferences,
    );
  }

  Future<bool> isAuthenticated() async {
    final data = await _httpClient.get(urlFragment: UrlFragment.me);
    if (data.isEmpty) {
      return false;
    }
    _user = User.fromJson(jsonDecode(data));
    return true;
  }

  Future<void> updateDefaultMediaAssetVolume(double value) async {
    final preferences = Preferences(defaultVolume: value.toInt());
    await _httpClient.post(
        urlFragment: UrlFragment.mePreferences, object: preferences);
    _setUser(preferences: preferences);
    notifyListeners();
  }

  Future<void> onLogin(String value) async {
    await _secureStorage.write(key: constants.appName, value: value);
    notifyListeners();
  }

  Future<void> onLogout() async {
    _user = User.defaultUser();
    await _secureStorage.delete(key: constants.appName);
    _httpClient.dispose();
    notifyListeners();
  }
}
