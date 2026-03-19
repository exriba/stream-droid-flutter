import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/providers/auth_interceptor.dart';
import 'package:stream_droid_app/src/providers/client_channel.dart';
import 'package:stream_droid_app/src/providers/secure_storage.dart';
import 'package:stream_droid_app/src/services/user_service.dart';

final userServiceProvider = Provider<UserService>((ref) {
  final secureStorage = ref.read(secureStorageProvider);
  final clientChannel = ref.read(clientChannelProvider);
  final authInterceptor = ref.read(authInterceptorProvider);
  return UserService(clientChannel, authInterceptor, secureStorage);
});
