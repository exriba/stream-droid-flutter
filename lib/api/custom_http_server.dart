import 'dart:io';
import 'package:stream_droid_app/common/constants.dart' as constants;

abstract class ICustomHttpServer {
  Future<void> initializeHttpServer(
      {required Future<void> Function({required String value}) onData});
  void dispose();
}

class CustomHttpServer implements ICustomHttpServer {
  HttpServer? _httpServer;

  @override
  Future<void> initializeHttpServer(
      {required Future<void> Function({required String value}) onData}) async {
    _httpServer =
        await HttpServer.bind(constants.serverAddress, constants.serverPort);

    await for (final request in _httpServer!) {
      final cookies = request.cookies.where(
        (element) => element.name == constants.appName,
      );

      if (cookies.isNotEmpty) {
        final cookie = cookies.first;
        await onData(value: cookie.value);
      }

      request.response.write("Close!");
      await request.response.close();
    }
  }

  @override
  void dispose() {
    _httpServer!.close();
    _httpServer = null;
  }
}
