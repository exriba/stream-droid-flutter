import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:eventflux/client.dart';
import 'package:eventflux/enum.dart';
import 'package:eventflux/models/response.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/util/secure_storage.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';
import 'package:stream_droid_app/common/constants.dart' as constants;

class MediaView extends StatefulWidget {
  const MediaView({super.key});

  @override
  State<StatefulWidget> createState() => _MediaView();
}

class _MediaView extends State<MediaView> {
  Player videoPlayer = Player();
  VideoController? videoController;
  List<Player> audioPlayers = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    final key = constants.appName;
    final secureStorage = DependencyManager.getIt.get<ISecureStorage>();
    final value = await secureStorage.read(key: key);

    videoPlayer.stream.completed.listen((completed) async {
      final currentMediaIndex = videoPlayer.state.playlist.index;
      final lastMediaIndex = videoPlayer.state.playlist.medias.length - 1;

      if (currentMediaIndex == lastMediaIndex) {
        setState(() {
          videoController = null;
        });
      }

      if (completed && mounted) {
        await videoPlayer.next();
      }
    });

    EventFlux.instance.connect(
      EventFluxConnectionType.get,
      constants.serverEventAddress,
      header: {
        HttpHeaders.cookieHeader: '$key=$value',
        HttpHeaders.acceptHeader: "text/event-stream",
        HttpHeaders.cacheControlHeader: "no-cache",
      },
      onSuccessCallback: (EventFluxResponse? response) {
        response?.stream?.listen((x) {
          if (x.event == 'AUDIO') {
            final json = jsonDecode(x.data);
            final assetEvent = AssetEvent.fromJson(json);
            playAudio(assetEvent);
          }
          if (x.event == 'VIDEO') {
            final json = jsonDecode(x.data);
            final assetEvent = AssetEvent.fromJson(json);
            playVideo(assetEvent);
          }
        });
      },
      onError: (error) async {
        await closeSseConnection();
        throw error;
      },
    );
  }

  Future<void> playAudio(AssetEvent event) async {
    final audioPlayer = Player();
    audioPlayer.stream.completed.listen((completed) async {
      if (completed && mounted) {
        await audioPlayer.dispose();
        audioPlayers.remove(audioPlayer);
      }
    });

    final playable = Media(event.uri);
    await audioPlayer.setVolume(event.volume.toDouble());
    await audioPlayer.open(playable);
    audioPlayers.add(audioPlayer);
  }

  Future<void> playVideo(AssetEvent event) async {
    final playable = Media(event.uri);
    await videoPlayer.setVolume(event.volume.toDouble());

    if (videoController == null) {
      setState(() {
        videoController = VideoController(videoPlayer);
      });
    }

    if (!videoPlayer.state.playing) {
      await videoPlayer.open(playable);
    } else {
      await videoPlayer.add(playable);
    }
  }

  @override
  Widget build(BuildContext context) {
    return videoController != null
        ? Video(
            controller: videoController!,
            controls: NoVideoControls,
          )
        : const SizedBox.shrink();
  }

  Future<void> releaseAudioPlayers() async {
    final futures1 = audioPlayers.map((e) => e.stop());
    await Future.wait(futures1);
    final futures2 = audioPlayers.map((e) => e.dispose());
    await Future.wait(futures2);
  }

  Future<void> releaseVideoPlayer() async {
    await videoPlayer.stop();
    videoController = null;
    await videoPlayer.dispose();
  }

  Future<void> closeSseConnection() async {
    await EventFlux.instance.disconnect();
  }

  @override
  void dispose() {
    releaseAudioPlayers();
    releaseVideoPlayer();
    closeSseConnection();
    super.dispose();
  }
}
