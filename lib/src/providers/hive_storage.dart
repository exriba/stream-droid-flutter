import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/services/hive_storage.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

final hiveStorageProvider = Provider<HiveStorage>((ref) {
  final hiveBox = Hive.box(constants.settings);
  return HiveStorage(hiveBox);
});
