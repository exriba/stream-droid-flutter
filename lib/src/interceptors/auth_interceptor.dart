import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:mutex/mutex.dart';
import 'package:stream_droid_app/src/services/secure_storage.dart';

class AuthInterceptor extends ClientInterceptor {
  AuthInterceptor(SecureStorage storage)
      : _storage = storage,
        _mutex = Mutex();

  final SecureStorage _storage;
  final Mutex _mutex;

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    final newOptions = options.mergedWith(
      CallOptions(providers: [_injectTokenProvider]),
    );

    final stream = invoker(method, requests, newOptions);
    stream.trailers.then(_handleTrailers);
    return stream;
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    final newOptions = options.mergedWith(
      CallOptions(providers: [_injectTokenProvider]),
    );

    final call = invoker(method, request, newOptions);
    call.headers.then(_handleTrailers);
    return call;
  }

  FutureOr<void> _injectTokenProvider(
    Map<String, String> metadata,
    String uri,
  ) async {
    final token = await _storage.getToken();
    if (token != null) {
      metadata['authorization'] = 'Bearer $token';
    }
  }

  FutureOr<void> _handleTrailers(Map<String, String> metadata) async {
    if (metadata.containsKey("access-token")) {
      final newToken = metadata["access-token"];
      await _mutex.protect(() async {
        final currentToken = await _storage.getToken();
        if (newToken != currentToken) {
          await _storage.saveToken(token: newToken!);
        }
      });
    }
  }
}
