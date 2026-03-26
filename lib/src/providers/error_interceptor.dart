import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/interceptors/global_error_interceptor.dart';

final errorInterceptorProvider = Provider<GlobalErrorInterceptor>((ref) {
  return GlobalErrorInterceptor(ref.container);
});
