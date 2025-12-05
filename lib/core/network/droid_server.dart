import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:stream_droid_app/core/constants/constants.dart' as constants;

class DroidServer {
  // TODO: Find a package that does this
  Future<void> initializeServer({
    required Future<void> Function(String? token) callback,
  }) async {
    String? token;

    HttpServer httpServer = await HttpServer.bind(
      constants.hostName,
      constants.hostPort,
    );

    await for (final request in httpServer) {
      switch (request.uri.path) {
        case '/callback':
          if (request.uri.queryParameters.containsKey('accessToken')) {
            token = request.uri.queryParameters['accessToken'];
            final content =
                await rootBundle.loadString('assets/html/Success.html');
            request.response.statusCode = HttpStatus.ok;
            request.response.headers
                .set('Content-Type', 'text/html; charset=utf-8');
            request.response.write(content);
          }
        default:
          final content = await rootBundle.loadString('assets/html/Error.html');
          request.response.statusCode = HttpStatus.unauthorized;
          request.response.headers
              .set('Content-Type', 'text/html; charset=utf-8');
          request.response.write(content);
      }

      await request.response.flush();
      await request.response.close();

      if (token != null) {
        break;
      }
    }

    await httpServer.close();
    await callback(token);
  }
}
