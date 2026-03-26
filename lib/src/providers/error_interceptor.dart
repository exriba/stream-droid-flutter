import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/interceptors/error_interceptor.dart';
import 'package:stream_droid_app/src/providers/error_handler.dart';

final errorInterceptorProvider = Provider<ErrorInterceptor>((ref) {
  final errorHandler = ref.read(errorHandlerProvider);
  return ErrorInterceptor(errorHandler);
});
