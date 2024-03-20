import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';

class MediaView extends StatefulWidget {
  const MediaView({super.key});

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

  Future<void> playAudio() async {
    audioPlayer = Player();
    audioPlayer!.stream.completed.listen((completed) async {
      if (completed) {
        await releaseAudioPlayer();
      }
    });

    try {
      final playable = Media('asset:///assets/file.mp3');
      await audioPlayer!.open(playable);
    } catch (e) {
      await releaseAudioPlayer();
    }
  }

  Future<void> playVideo() async {
    videoPlayer = Player();
    videoPlayer!.stream.completed.listen((completed) async {
      if (completed) {
        await releaseVideoPlayer();
      }
    });

    setState(() {
      videoController = VideoController(videoPlayer!);
    });

    try {
      final playable = Media('asset:///assets/file.mp4');
      await videoPlayer!.open(playable);
    } catch (e) {
      await releaseVideoPlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      viewDestination: ViewDestination.media,
      child: videoController != null
          ? Video(
              controller: videoController!,
              controls: NoVideoControls,
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    releaseAudioPlayer();
    releaseVideoPlayer();
  }

  Future<void> releaseAudioPlayer() async {
    if (audioPlayer != null) {
      await audioPlayer!.dispose();
    }
    audioPlayer = null;
  }

  Future<void> releaseVideoPlayer() async {
    videoController = null;
    if (videoPlayer != null) {
      await videoPlayer!.dispose();
    }
    videoPlayer = null;
  }
}
