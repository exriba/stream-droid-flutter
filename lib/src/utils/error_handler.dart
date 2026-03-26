import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:stream_droid_app/src/providers/global_error.dart';

class ErrorHandler {
  ErrorHandler(ProviderContainer container) : _container = container;
  final ProviderContainer _container;

  void handle(dynamic error) {
    String message = "Unexpected error";

    if (error is GrpcError) {
      message = _mapGrpcError(error);
    }

    final errorProvider = _container.read(globalErrorProvider.notifier);
    errorProvider.state = message;

    // TODO: Log this
    debugPrint('Error caught: $error');
  }

  static String _mapGrpcError(GrpcError error) {
    switch (error.code) {
      case StatusCode.cancelled:
        return "Request cancelled.";
      case StatusCode.unknown:
        return "Unknown error.";
      case StatusCode.invalidArgument:
        return "Invalid request.";
      case StatusCode.deadlineExceeded:
        return "Request timeout.";
      case StatusCode.notFound:
        return "Not found.";
      case StatusCode.permissionDenied:
        return "Permission denied.";
      case StatusCode.unauthenticated:
        return "Session expired.";
      case StatusCode.unavailable:
        return "Service unavailable";
      default:
        return error.message ?? "Unexpected error";
    }
  }
}
