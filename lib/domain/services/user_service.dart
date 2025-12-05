import 'package:stream_droid_app/core/network/droid_client.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/core/utils/secure_storage.dart';
import 'package:stream_droid_app/core/constants/constants.dart' as constants;

class UserService {
  UserService(this._secureStorage, this._httpClient);
  final ISecureStorage _secureStorage;
  final IDroidClient _httpClient;

  Future<String> authorizationUrl() async {
    return await _httpClient.get(urlFragment: UrlFragment.meLogin);
  }

  Future<bool> isAuthenticated() async {
    final data = await _httpClient.get(urlFragment: UrlFragment.me);
    return data.isNotEmpty;
  }

  Future<void> onLogin(String value) async {
    await _secureStorage.write(key: constants.appName, value: value);
  }

  Future<void> onLogout() async {
    await _secureStorage.delete(key: constants.appName);
    _httpClient.dispose();
  }
}
