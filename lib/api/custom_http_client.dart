import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';
import 'package:stream_droid_app/util/secure_storage.dart';
import 'package:stream_droid_app/common/constants.dart' as constants;

abstract class ICustomHttpClient {
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

class CustomHttpClient implements ICustomHttpClient {
  final _AuthenticatedHttpClient _httpClient = _AuthenticatedHttpClient();

  @override
  Future<String> get({required UrlFragment urlFragment, String? id}) async {
    final request =
        http.Request(HttpMethod.get.method, urlFragment.getFragment(id: id));
    final response = await _httpClient.send(request);
    return response.stream.bytesToString();
  }

  @override
  Future<void> post(
      {required UrlFragment urlFragment, String? id, Object? object}) async {
    final request =
        http.Request(HttpMethod.post.method, urlFragment.getFragment(id: id));
    request.headers.putIfAbsent("Content-Type", () => "application/json");
    request.body = json.encode(object);

    await _httpClient.send(request);
  }

  @override
  Future<void> multipart(
      {required UrlFragment urlFragment,
      String? id,
      Map<String, dynamic>? fields,
      required List<File> files}) async {
    final request = http.MultipartRequest(
        HttpMethod.post.method, urlFragment.getFragment(id: id));
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
    await _httpClient.send(request);
  }

  @override
  Future<void> put(
      {required UrlFragment urlFragment, String? id, Object? object}) async {
    final request =
        http.Request(HttpMethod.put.method, urlFragment.getFragment(id: id));
    request.headers.putIfAbsent("Content-Type", () => "application/json");
    request.body = json.encode(object);

    await _httpClient.send(request);
  }

  @override
  Future<void> delete(
      {required UrlFragment urlFragment,
      String? id,
      Map<String, String>? headers}) async {
    final request =
        http.Request(HttpMethod.delete.method, urlFragment.getFragment(id: id));
    headers?.forEach((key, value) {
      request.headers.putIfAbsent(key, () => Uri.encodeComponent(value));
    });

    await _httpClient.send(request);
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}

class _AuthenticatedHttpClient extends http.BaseClient {
  String _authCookie = '';
  final baseAddress = constants.hostAddress;
  late ISecureStorage secureStorage;

  _AuthenticatedHttpClient() {
    secureStorage = DependencyManager.getIt.get<ISecureStorage>();
  }

  Future<String> get authCookie async {
    if (_authCookie.isNotEmpty) {
      return _authCookie;
    }

    _authCookie = await loadAuthCookieFromSecureStorage();
    return _authCookie;
  }

  Future<String> loadAuthCookieFromSecureStorage() async {
    const key = constants.appName;
    final value = await secureStorage.read(key: key);
    return value != null ? '$key=$value' : '';
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers.putIfAbsent(HttpHeaders.refererHeader, () => baseAddress);

    final cookie = await authCookie;
    if (cookie.isNotEmpty) {
      request.headers.putIfAbsent(HttpHeaders.cookieHeader, () => cookie);
    }

    return await request.send();
  }

  @override
  void close() {
    super.close();
    _authCookie = '';
  }
}
