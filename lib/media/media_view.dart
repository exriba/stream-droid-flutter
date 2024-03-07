import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:stream_droid_app/layout/base_view.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';
import 'package:stream_droid_app/utils/view_destination.dart';

class MediaView extends StatefulWidget with BaseView {
  const MediaView({super.key});

  @override
  ViewDestination get view => ViewDestination.media;

  @override
  State<StatefulWidget> createState() => _MediaView();
}

class _MediaView extends State<MediaView> {
  late VideoController? videoController;

  @override
  void initState() {
    super.initState();
    playVideo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> playAudio() async {
    final player = Player();
    player.stream.completed.listen((completed) async {
      if (completed) {
        await player.dispose();
      }
    });

    try {
      final playable = Media('asset:///assets/file.mp3');
      await player.open(playable);
    } catch (e) {
      await player.dispose();
    }
  }

  Future<void> playVideo() async {
    final player = Player();
    player.stream.completed.listen((completed) async {
      if (completed) {
        await player.dispose();
      }
    });

    setState(() {
      videoController = VideoController(player);
    });

    try {
      final playable = Media('asset:///assets/file.mp4');
      await player.open(playable);
    } catch (e) {
      await player.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      baseView: widget,
      child: Align(
        alignment: Alignment.center,
        child: videoController != null
            ? Video(
                controller: videoController!,
                controls: NoVideoControls,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
