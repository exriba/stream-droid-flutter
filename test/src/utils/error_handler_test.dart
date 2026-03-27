import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/src/providers/global_error.dart';
import 'package:stream_droid_app/src/utils/error_handler.dart';

// import your files

void main() {
  group('ErrorHandler', () {
    late ProviderContainer container;
    late ErrorHandler handler;

    setUp(() {
      container = ProviderContainer();
      handler = ErrorHandler(container);
    });

    tearDown(() {
      container.dispose();
    });

    test('maps all grpc status codes', () {
      final cases = {
        StatusCode.cancelled: 'Request cancelled.',
        StatusCode.unknown: 'Unknown error.',
        StatusCode.invalidArgument: 'Invalid request.',
        StatusCode.deadlineExceeded: 'Request timeout.',
        StatusCode.notFound: 'Not found.',
        StatusCode.permissionDenied: 'Permission denied.',
        StatusCode.unauthenticated: 'Session expired.',
        StatusCode.unavailable: 'Service unavailable',
      };

      for (final entry in cases.entries) {
        final error = GrpcError.custom(entry.key);
        handler.handle(error);
        final message = container.read(globalErrorProvider);
        expect(message, entry.value);
      }
    });
  });
}
