import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:stream_droid_app/src/providers/media_notification.dart';
import 'package:stream_droid_app/src/utils/async_value_view.dart';

class MediaScreen extends ConsumerWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNotifierState = ref.watch(eventNotificationProvider);

    return AsyncValueView<VideoController>(
      value: eventNotifierState,
      builder: (controller) => Video(
        controller: controller,
        controls: NoVideoControls,
      ),
    );
  }
}
