import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/providers/error_handler.dart';
import 'package:stream_droid_app/src/services/service_control.dart';

final serviceControlProvider = Provider<ServiceControl>((ref) {
  final errorHandler = ref.read(errorHandlerProvider);
  return ServiceControl(errorHandler);
});
