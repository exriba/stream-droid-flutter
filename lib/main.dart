import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:media_kit/media_kit.dart';
import 'package:stream_droid_app/src/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/services/window_service.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await WindowService.ensureInitialized();
      await Hive.initFlutter();
      await Hive.openBox(constants.settings);
      MediaKit.ensureInitialized();

      runApp(
        const ProviderScope(
          child: App(),
        ),
      );
    },
    (error, stackTrace) {
      // TODO: Review error handling
      debugPrint('Uncaught error in zone: $error');
    },
  );
}
