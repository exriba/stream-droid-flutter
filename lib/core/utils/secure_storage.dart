import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stream_droid_app/core/constants/constants.dart' as constants;

abstract class ISecureStorage {
  Future<String?> getToken();
  Future<void> saveToken({required String token});
  Future<void> deleteToken();
}

class SecureStorage implements ISecureStorage {
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  @override
  Future<String?> getToken() async {
    return await _flutterSecureStorage.read(key: constants.appName);
  }

  @override
  Future<void> saveToken({required String token}) async {
    await _flutterSecureStorage.write(key: constants.appName, value: token);
  }

  @override
  Future<void> deleteToken() async {
    await _flutterSecureStorage.delete(key: constants.appName);
  }
}
