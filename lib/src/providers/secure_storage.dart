import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/services/secure_storage.dart';

part 'secure_storage.g.dart';

@Riverpod(keepAlive: true)
SecureStorage secureStorage(SecureStorageRef ref) {
  const secureStorage = FlutterSecureStorage();
  return SecureStorage(secureStorage);
}
