import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/network/droid_client.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/core/utils/local_storage.dart';
import 'package:stream_droid_app/core/utils/secure_storage.dart';
import 'package:stream_droid_app/core/constants/constants.dart' as constants;

const defaultVolumeKey = 'defaultVolume';

class UserContext extends ChangeNotifier {
  UserContext() {
    _localStorage = DependencyManager.getIt.get<ILocalStorage>();
    _secureStorage = DependencyManager.getIt.get<ISecureStorage>();
    _httpClient = DependencyManager.getIt.get<IDroidClient>();
  }
  late ILocalStorage _localStorage;
  late ISecureStorage _secureStorage;
  late IDroidClient _httpClient;

  double? _defaultVolume;

  double get defaultMediaAssetVolume {
    if (_defaultVolume != null) {
      return _defaultVolume!;
    }

    final value = _localStorage.read(key: defaultVolumeKey) ?? '50';
    _defaultVolume = double.parse(value);
    return _defaultVolume!;
  }

  void updateDefaultMediaAssetVolume(double value) {
    _localStorage.write(key: defaultVolumeKey, value: value.toString());
    _defaultVolume = value;
    notifyListeners();
  }

  Future<bool> isAuthenticated() async {
    final data = await _httpClient.get(urlFragment: UrlFragment.me);
    return data.isNotEmpty;
  }

  Future<void> onLogin(String value) async {
    await _secureStorage.write(key: constants.appName, value: value);
  }

  Future<void> onLogout() async {
    await _secureStorage.delete(key: constants.appName);
    _httpClient.dispose();
  }
}
