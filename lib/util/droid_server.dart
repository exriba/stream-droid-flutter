import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:stream_droid_app/common/constants.dart' as constants;
import 'package:talker/talker.dart';

class DroidServer {
  Future<void> initializeServer({
    required Future<void> Function(Cookie? cookie, String? token) callback,
  }) async {
    Cookie? cookie;
    String? token;
    bool completed = false;
    final redirectUri = Uri.parse(constants.redirectUrl);

    HttpServer httpServer = await HttpServer.bind(
      constants.hostName,
      constants.hostPort,
    );

    await for (final request in httpServer) {
      String content = '';
      request.response.headers.set('Content-Type', 'text/html; charset=utf-8');

      if (request.requestedUri == redirectUri) {
        cookie = request.cookies.firstWhereLogTypeOrNull(
          (cookie) => cookie.name == constants.appName,
        );
        token = request.uri.queryParameters['accessToken'];
        content = await rootBundle.loadString('assets/html/Success.html');
        request.response.statusCode = HttpStatus.ok;
        completed = true;
      } else {
        content = await rootBundle.loadString('assets/html/Error.html');
        request.response.statusCode = HttpStatus.unauthorized;
      }

      request.response.write(content);
      await request.response.flush();
      await request.response.close();

      if (completed) {
        break;
      }
    }

    await httpServer.close();
    await callback(cookie, token);
  }
}
