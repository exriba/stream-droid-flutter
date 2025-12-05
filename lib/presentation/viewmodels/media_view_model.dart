import 'dart:io';
import 'dart:convert';
import 'package:eventflux/client.dart';
import 'package:eventflux/enum.dart';
import 'package:eventflux/models/response.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:stream_droid_app/core/constants/constants.dart' as constants;
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/core/utils/secure_storage.dart';
import 'package:stream_droid_app/data/models/asset_event.dart';

class MediaViewModel extends ChangeNotifier {
  VideoController? videoController;
  final Player _videoPlayer = Player();
  final List<Player> _audioPlayers = List.empty(growable: true);

  Future<void> initialize() async {
    final key = constants.appName;
    final secureStorage = DependencyManager.getIt.get<ISecureStorage>();
    final token = await secureStorage.read(key: key);

    _videoPlayer.stream.completed.listen((completed) async {
      final currentMediaIndex = _videoPlayer.state.playlist.index;
      final lastMediaIndex = _videoPlayer.state.playlist.medias.length - 1;

      if (currentMediaIndex == lastMediaIndex) {
        videoController = null;
        notifyListeners();
      }

      if (completed && hasListeners) {
        await _videoPlayer.next();
      }
    });

    EventFlux.instance.connect(
      EventFluxConnectionType.get,
      constants.serverEventAddress,
      header: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
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
        await _closeSseConnection();
      },
    );
  }

  Future<void> playAudio(AssetEvent event) async {
    final audioPlayer = Player();
    audioPlayer.stream.completed.listen((completed) async {
      if (completed && hasListeners) {
        await audioPlayer.dispose();
        _audioPlayers.remove(audioPlayer);
      }
    });

    final playable = Media(event.uri);
    await audioPlayer.setVolume(event.volume.toDouble());
    await audioPlayer.open(playable);
    _audioPlayers.add(audioPlayer);
  }

  Future<void> playVideo(AssetEvent event) async {
    final playable = Media(event.uri);
    await _videoPlayer.setVolume(event.volume.toDouble());

    if (videoController == null) {
      videoController = VideoController(_videoPlayer);
      notifyListeners();
    }

    if (!_videoPlayer.state.playing) {
      await _videoPlayer.open(playable);
    } else {
      await _videoPlayer.add(playable);
    }
  }

  Future<void> _releaseAudioPlayers() async {
    final futures1 = _audioPlayers.map((player) => player.stop());
    await Future.wait(futures1);
    final futures2 = _audioPlayers.map((player) => player.dispose());
    await Future.wait(futures2);
  }

  Future<void> _releaseVideoPlayer() async {
    await _videoPlayer.stop();
    videoController = null;
    await _videoPlayer.dispose();
  }

  Future<void> _closeSseConnection() async {
    await EventFlux.instance.disconnect();
  }

  @override
  void dispose() {
    _closeSseConnection();
    _releaseAudioPlayers();
    _releaseVideoPlayer();
    super.dispose();
  }
}
