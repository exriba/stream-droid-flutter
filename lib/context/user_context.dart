import 'package:flutter/material.dart';
import 'package:stream_droid_app/api/custom_http_client.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';
import 'package:stream_droid_app/util/local_storage.dart';
import 'package:stream_droid_app/util/secure_storage.dart';
import 'package:stream_droid_app/common/constants.dart' as constants;

const defaultVolumeKey = 'defaultVolume';

class UserContext extends ChangeNotifier {
  UserContext() {
    _localStorage = DependencyManager.getIt.get<ILocalStorage>();
    _secureStorage = DependencyManager.getIt.get<ISecureStorage>();
    _httpClient = DependencyManager.getIt.get<ICustomHttpClient>();
  }
  late ILocalStorage _localStorage;
  late ISecureStorage _secureStorage;
  late ICustomHttpClient _httpClient;

  double get defaultMediaAssetVolume {
    final value = _localStorage.read(key: defaultVolumeKey) ?? '50';
    return double.parse(value);
  }

  Future<bool> isAuthenticated() async {
    final data = await _httpClient.get(urlFragment: UrlFragment.me);
    return data.isNotEmpty;
  }

  Future<void> updateDefaultMediaAssetVolume(double value) async {
    _localStorage.write(key: defaultVolumeKey, value: value.toString());
    notifyListeners();
  }

  Future<void> onLogin(String value) async {
    await _secureStorage.write(key: constants.appName, value: value);
    notifyListeners();
  }

  Future<void> onLogout() async {
    await _secureStorage.delete(key: constants.appName);
    _httpClient.dispose();
    notifyListeners();
  }
}
