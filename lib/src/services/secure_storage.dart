import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

class SecureStorage {
  SecureStorage({required this.storage});
  final FlutterSecureStorage storage;

  Future<String?> getToken() async {
    return await storage.read(key: constants.appName);
  }

  Future<void> saveToken({required String token}) async {
    await storage.write(key: constants.appName, value: token);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: constants.appName);
  }
}
