import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/interceptors/error_interceptor.dart';

final errorInterceptorProvider = Provider<ErrorInterceptor>((ref) {
  return ErrorInterceptor(ref.container);
});
