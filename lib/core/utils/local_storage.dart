import 'package:localstorage/localstorage.dart';

abstract class ILocalStorage {
  String? read({required String key});
  void write({required String key, required String value});
  void delete({required String key});
}

class LocalStorage implements ILocalStorage {
  @override
  String? read({required String key}) {
    return localStorage.getItem(key);
  }

  @override
  void write({required String key, required String value}) {
    localStorage.setItem(key, value);
  }

  @override
  void delete({required String key}) {
    localStorage.removeItem(key);
  }
}
