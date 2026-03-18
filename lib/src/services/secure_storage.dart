import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

class SecureStorage {
  SecureStorage() {
    _flutterSecureStorage = const FlutterSecureStorage();
  }
  late final FlutterSecureStorage _flutterSecureStorage;

  Future<String?> getToken() async {
    return await _flutterSecureStorage.read(key: constants.appName);
  }

  Future<void> saveToken({required String token}) async {
    await _flutterSecureStorage.write(key: constants.appName, value: token);
  }

  Future<void> deleteToken() async {
    await _flutterSecureStorage.delete(key: constants.appName);
  }
}
