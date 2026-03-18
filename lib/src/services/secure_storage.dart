import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

class SecureStorage {
  SecureStorage(FlutterSecureStorage secureStorage) : _storage = secureStorage;
  final FlutterSecureStorage _storage;

  Future<String?> getToken() async {
    return await _storage.read(key: constants.appName);
  }

  Future<void> saveToken({required String token}) async {
    await _storage.write(key: constants.appName, value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: constants.appName);
  }
}
