import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/services/hive_storage.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

part 'hive_storage.g.dart';

@riverpod
HiveStorage hiveStorage(HiveStorageRef ref) {
  final hiveBox = Hive.box(constants.settings);
  return HiveStorage(hiveBox);
}
