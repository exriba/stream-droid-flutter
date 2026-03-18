import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/controllers/user_controller.dart';
import 'package:stream_droid_app/src/providers/auth_interceptor.dart';
import 'package:stream_droid_app/src/providers/client_channel.dart';
import 'package:stream_droid_app/src/providers/secure_storage.dart';
import 'package:stream_droid_app/src/services/user_service.dart';

part 'users.g.dart';

@riverpod
UserService userService(UserServiceRef ref) {
  final clientChannel = ref.read(clientChannelProvider);
  final authInterceptor = ref.read(authInterceptorProvider);
  return UserService(clientChannel, authInterceptor);
}

@riverpod
UserController userController(UserControllerRef ref) {
  final secureStorage = ref.read(secureStorageProvider);
  final userService = ref.read(userServiceProvider);
  return UserController(service: userService, storage: secureStorage);
}
