import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:stream_droid_app/src/providers/media_event.dart';

class MediaEventScreen extends ConsumerStatefulWidget {
  const MediaEventScreen({super.key});

  @override
  ConsumerState<MediaEventScreen> createState() => _MediaEventScreen();
}

class _MediaEventScreen extends ConsumerState<MediaEventScreen> {
  @override
  Widget build(BuildContext context) {
    ref.watch(mediaEventProvider);
    final controller = ref.read(mediaEventProvider.notifier).videoController;

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
        controller: controller,
        controls: NoVideoControls,
      ),
    );
  }

  @override
  void deactivate() {
    ref.invalidate(mediaEventProvider);
    super.deactivate();
  }
}
