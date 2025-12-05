import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/core/utils/local_storage.dart';

class PreferenceContext extends ChangeNotifier {
  PreferenceContext() {
    _localStorage = DependencyManager.getIt.get<ILocalStorage>();
  }

  double? _defaultVolume;
  late ILocalStorage _localStorage;
  final String _defaultVolumeKey = 'defaultVolume';

  double get defaultMediaAssetVolume {
    if (_defaultVolume != null) {
      return _defaultVolume!;
    }

    final value = _localStorage.read(key: _defaultVolumeKey) ?? '50';
    _defaultVolume = double.parse(value);
    return _defaultVolume!;
  }

  void updateDefaultMediaAssetVolume(double value) {
    _localStorage.write(key: _defaultVolumeKey, value: value.toString());
    _defaultVolume = value;
    notifyListeners();
  }
}
