import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/core/utils/secure_storage.dart';
import 'package:stream_droid_app/core/constants/constants.dart' as constants;

abstract class IDroidClient {
  Future<String> get({
    required UrlFragment urlFragment,
    String? id,
  });
  Future<void> post({
    required UrlFragment urlFragment,
    String? id,
    Object? object,
  });
  Future<void> multipart({
    required UrlFragment urlFragment,
    String? id,
    Map<String, String>? fields,
    required List<File> files,
  });
  Future<void> put({
    required UrlFragment urlFragment,
    String? id,
    Object? object,
  });
  Future<void> delete({
    required UrlFragment urlFragment,
    String? id,
    Map<String, String>? headers,
  });
  void dispose();
}

class DroidClient implements IDroidClient {
  DroidClient(ISecureStorage secureStorage) {
    _secureStorage = secureStorage;
  }

  String _accessToken = '';
  late ISecureStorage _secureStorage;
  late bool _disposed = false;
  late http.Client _innerClient = http.Client();

  http.Client get _client {
    if (!_disposed) {
      return _innerClient;
    }

    _disposed = false;
    _innerClient = http.Client();
    return _innerClient;
  }

  Future<String> get accessToken async {
    if (_accessToken.isNotEmpty) {
      return _accessToken;
    }

    _accessToken = await _loadAccessTokenFromSecureStorage();
    return _accessToken;
  }

  Future<String> _loadAccessTokenFromSecureStorage() async {
    const key = constants.appName;
    final value = await _secureStorage.read(key: key);
    return value != null ? 'Bearer $value' : '';
  }

  Future<Map<String, String>> _configureHeaders() async {
    final token = await accessToken;
    return {
      HttpHeaders.refererHeader: constants.redirectUrl,
      HttpHeaders.authorizationHeader: token
    };
  }

  @override
  Future<String> get({required UrlFragment urlFragment, String? id}) async {
    final url = urlFragment.getFragment(id: id);
    final headers = await _configureHeaders();
    final response = await _client.get(url, headers: headers);
    return response.body;
  }

  @override
  Future<void> post(
      {required UrlFragment urlFragment, String? id, Object? object}) async {
    final url = urlFragment.getFragment(id: id);
    final headers = await _configureHeaders();
    headers.putIfAbsent("Content-Type", () => "application/json");
    final body = json.encode(object);
    await _client.post(url, headers: headers, body: body);
  }

  @override
  Future<void> multipart(
      {required UrlFragment urlFragment,
      String? id,
      Map<String, dynamic>? fields,
      required List<File> files}) async {
    final url = urlFragment.getFragment(id: id);
    final headers = await _configureHeaders();
    final request = http.MultipartRequest(HttpMethod.post.method, url);
    request.headers.addAll(headers);
    fields?.forEach((key, value) {
      request.fields[key] = value;
    });
    for (var file in files) {
      final multiPartFile = await http.MultipartFile.fromPath(
        'Files',
        file.path,
      );
      request.files.add(multiPartFile);
    }
    await _client.send(request);
  }

  @override
  Future<void> put(
      {required UrlFragment urlFragment, String? id, Object? object}) async {
    final url = urlFragment.getFragment(id: id);
    final headers = await _configureHeaders();
    headers.putIfAbsent("Content-Type", () => "application/json");
    final body = json.encode(object);
    await _client.put(url, headers: headers, body: body);
  }

  @override
  Future<void> delete(
      {required UrlFragment urlFragment,
      String? id,
      Map<String, String>? headers}) async {
    final url = urlFragment.getFragment(id: id);
    final requestHeaders = await _configureHeaders();
    headers?.forEach((key, value) {
      requestHeaders.putIfAbsent(key, () => Uri.encodeComponent(value));
    });
    await _client.delete(url, headers: requestHeaders);
  }

  @override
  void dispose() {
    _accessToken = '';
    _disposed = true;
    _innerClient.close();
  }
}
