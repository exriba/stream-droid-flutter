import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
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
      switch (request.uri.path) {
        case '/':
          if (cookies.isNotEmpty) {
            final cookie = cookies.first;
            final content =
                await rootBundle.loadString('assets/html/Success.html');
            request.response.statusCode = HttpStatus.ok;
            request.response.headers
                .set('Content-Type', 'text/html; charset=utf-8');
            request.response.write(content);
            onData(value: cookie.value);
          }
        case '/favicon.ico':
          final image = File("assets/icons/favicon.ico");
          final rawImage = await image.readAsBytes();
          request.response.statusCode = HttpStatus.ok;
          request.response.headers.set('Content-Type', 'image/x-icon');
          request.response.headers.set('Content-Length', rawImage.length);
          request.response.add(rawImage);
        case '/app-icon.png':
          final image = File("assets/images/app-icon.png");
          final rawImage = await image.readAsBytes();
          request.response.statusCode = HttpStatus.ok;
          request.response.headers.set('Content-Type', 'image/png');
          request.response.headers.set('Content-Length', rawImage.length);
          request.response.add(rawImage);
        case '/manifest.json':
          final content =
              await rootBundle.loadString('assets/html/manifest.json');
          request.response.statusCode = HttpStatus.ok;
          request.response.headers.set('Content-Type', 'application/json');
          request.response.write(content);
        default:
          final content = await rootBundle.loadString('assets/html/Error.html');
          request.response.statusCode = HttpStatus.methodNotAllowed;
          request.response.headers
              .set('Content-Type', 'text/html; charset=utf-8');
          request.response.write(content);
      }
      await request.response.close();
    }
  }

  @override
  void dispose() {
    _httpServer!.close();
    _httpServer = null;
  }
}
