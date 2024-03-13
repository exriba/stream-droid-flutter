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
  Player? videoPlayer;
  Player? audioPlayer;
  VideoController? videoController;

  @override
  void initState() {
    super.initState();
    playVideo();
    playAudio();
  }

  @override
  void dispose() {
    audioPlayer?.dispose();
    videoPlayer?.dispose();
    super.dispose();
  }

  Future<void> playAudio() async {
    audioPlayer = Player();
    audioPlayer!.stream.completed.listen((completed) async {
      if (completed) {
        await audioPlayer!.dispose();
        audioPlayer = null;
      }
    });

    try {
      final playable = Media('asset:///assets/file.mp3');
      await audioPlayer!.open(playable);
    } catch (e) {
      await audioPlayer!.dispose();
    }
  }

  Future<void> playVideo() async {
    videoPlayer = Player();
    videoPlayer!.stream.completed.listen((completed) async {
      if (completed) {
        await videoPlayer!.dispose();
        videoPlayer = null;
      }
    });

    setState(() {
      videoController = VideoController(videoPlayer!);
    });

    try {
      final playable = Media('asset:///assets/file.mp4');
      await videoPlayer!.open(playable);
    } catch (e) {
      await videoPlayer!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      baseView: widget,
      child: videoController != null
          ? Video(
              controller: videoController!,
              controls: NoVideoControls,
            )
          : const SizedBox.shrink(),
    );
  }
}
