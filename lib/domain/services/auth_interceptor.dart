import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/core/utils/secure_storage.dart';
import 'package:stream_droid_app/core/constants/constants.dart' as constants;

class AuthInterceptor implements ClientInterceptor {
  AuthInterceptor(this._secureStorage);
  final ISecureStorage _secureStorage;

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
      ClientMethod<Q, R> method,
      Stream<Q> requests,
      CallOptions options,
      ClientStreamingInvoker<Q, R> invoker) {
    return invoker(
      method,
      requests,
      options.mergedWith(CallOptions(providers: [_provider])),
    );
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    return invoker(
      method,
      request,
      options.mergedWith(CallOptions(providers: [_provider])),
    );
  }

  FutureOr<void> _provider(Map<String, String> metadata, String uri) async {
    final token = await _secureStorage.read(key: constants.appName);
    metadata['Authorization'] = "Bearer $token";
  }
}
