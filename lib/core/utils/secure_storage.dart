import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ISecureStorage {
  Future<String?> read({required String key});
  Future<void> write({required String key, required String value});
  Future<void> delete({required String key});
}

class SecureStorage implements ISecureStorage {
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  @override
  Future<String?> read({required String key}) async {
    return await _flutterSecureStorage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await _flutterSecureStorage.write(key: key, value: value);
  }

  @override
  Future<void> delete({required String key}) async {
    await _flutterSecureStorage.delete(key: key);
  }
}
