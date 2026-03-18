import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:stream_droid_app/src/controllers/media_event_controller.dart';

class MediaEventScreen extends ConsumerWidget {
  const MediaEventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaEventController = ref.watch(mediaEventControllerProvider);

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 4, 4, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Video(
        controller: mediaEventController.controller,
        controls: NoVideoControls,
      ),
    );
  }
}
