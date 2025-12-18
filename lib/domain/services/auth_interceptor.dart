import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/core/utils/secure_storage.dart';

class AuthInterceptor implements ClientInterceptor {
  AuthInterceptor(this._secureStorage);
  final ISecureStorage _secureStorage;

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
      ClientMethod<Q, R> method,
      Stream<Q> requests,
      CallOptions options,
      ClientStreamingInvoker<Q, R> invoker) {
    final newOptions = options.mergedWith(
      CallOptions(providers: [_injectTokenProvider]),
    );

    final call = invoker(method, requests, newOptions);

    call.headers.then(_handleResponseMetadata);

    return call;
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    final newOptions = options.mergedWith(
      CallOptions(providers: [_injectTokenProvider]),
    );

    final call = invoker(method, request, newOptions);

    call.headers.then(_handleResponseMetadata);

    return call;
  }

  FutureOr<void> _injectTokenProvider(
      Map<String, String> metadata, String uri) async {
    final token = await _secureStorage.getToken();
    if (token != null) {
      metadata['authorization'] = 'Bearer $token';
    }
  }

  FutureOr<void> _handleResponseMetadata(Map<String, String> metadata) async {
    final bearerToken = metadata['authorization'];
    if (bearerToken != null) {
      final token = bearerToken.startsWith('Bearer ')
          ? bearerToken.substring(7)
          : bearerToken;
      await _secureStorage.saveToken(token: token);
    }
  }
}
