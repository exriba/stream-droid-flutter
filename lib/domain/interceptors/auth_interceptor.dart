import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:mutex/mutex.dart';
import 'package:stream_droid_app/core/utils/secure_storage.dart';

class AuthInterceptor implements ClientInterceptor {
  AuthInterceptor(this._secureStorage) {
    _tokenUpdateMutex = Mutex();
  }
  final ISecureStorage _secureStorage;
  late Mutex _tokenUpdateMutex;

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
    call.trailers.then(_handleTrailers);
    return call;
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    final newOptions = options.mergedWith(
      CallOptions(providers: [_injectTokenProvider]),
    );

    final call = invoker(method, request, newOptions);
    call.headers.then(_handleTrailers);
    return call;
  }

  FutureOr<void> _injectTokenProvider(
      Map<String, String> metadata, String uri) async {
    final token = await _secureStorage.getToken();
    if (token != null) {
      metadata['authorization'] = 'Bearer $token';
    }
  }

  FutureOr<void> _handleTrailers(Map<String, String> metadata) async {
    if (metadata.containsKey("access-token")) {
      final newToken = metadata["access-token"];
      await _tokenUpdateMutex.protect(() async {
        final currentToken = await _secureStorage.getToken();
        if (newToken != currentToken) {
          await _secureStorage.saveToken(token: newToken!);
        }
      });
    }
  }
}
