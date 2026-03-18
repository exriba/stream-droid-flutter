import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  HiveStorage(this._box);
  final Box _box;

  Future<void> set(String key, dynamic value) async {
    await _box.put(key, value);
  }

  T get<T>(String key, {T? defaultValue}) {
    return _box.get(key, defaultValue: defaultValue) as T;
  }
}
