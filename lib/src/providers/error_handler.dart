import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/utils/error_handler.dart';

final errorHandlerProvider = Provider<ErrorHandler>((ref) {
  return ErrorHandler(ref.container);
});
