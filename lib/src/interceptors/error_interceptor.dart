import 'package:grpc/grpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/utils/error_handler.dart';

class ErrorInterceptor extends ClientInterceptor {
  ErrorInterceptor(ErrorHandler errorHandler) : _errorHandler = errorHandler;
  final ErrorHandler _errorHandler;

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    final stream = invoker(method, requests, options);
    stream.handleError((error) {
      _errorHandler.handle(error);
      throw error;
    });
    return stream;
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    final call = invoker(method, request, options);
    call.catchError((error) {
      _errorHandler.handle(error);
      throw error;
    });
    return call;
  }
}
