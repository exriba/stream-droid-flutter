import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:stream_droid_app/src/providers/media_notification.dart';
import 'package:stream_droid_app/src/widgets/loading_spinner.dart';

class MediaScreen extends ConsumerWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(eventNotificationProvider);

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 4, 4, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: notifier.when(
        data: (controller) => Video(
          controller: controller,
          controls: NoVideoControls,
        ),
        error: (_, __) => const SizedBox.shrink(),
        loading: () => const LoadingSpinner(),
      ),
    );
  }
}
