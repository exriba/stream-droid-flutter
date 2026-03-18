import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/interceptors/auth_interceptor.dart';
import 'package:stream_droid_app/src/providers/secure_storage.dart';

part 'auth_interceptor.g.dart';

@riverpod
AuthInterceptor authInterceptor(AuthInterceptorRef ref) {
  final secureStorage = ref.read(secureStorageProvider);
  return AuthInterceptor(secureStorage);
}
