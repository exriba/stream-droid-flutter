import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  HiveStorage({required this.box});
  final Box box;

  Future<void> set(String key, dynamic value) async {
    await box.put(key, value);
  }

  T get<T>(String key, {T? defaultValue}) {
    return box.get(key, defaultValue: defaultValue) as T;
  }
}
