import 'package:flutter/services.dart';
import 'package:stream_droid_app/src/utils/error_handler.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

const String _channelName = 'stream_droid.service_control';

class ServiceControl {
  ServiceControl(ErrorHandler errorHandler)
      : _channel = const MethodChannel(_channelName),
        _errorHandler = errorHandler;
  final MethodChannel _channel;
  final ErrorHandler _errorHandler;

  Future<bool> isServiceRunning() async {
    try {
      final result = await _channel.invokeMethod<bool>(
        'isServiceRunning',
        {'serviceName': constants.appName},
      );
      return result ?? false;
    } on PlatformException catch (error) {
      _errorHandler.handle(error);
      return false;
    }
  }
}
