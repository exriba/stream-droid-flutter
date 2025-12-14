import 'package:grpc/grpc.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/domain/generated/common/event.pb.dart';
import 'package:stream_droid_app/domain/generated/service/eventservice.pb.dart';
import 'package:stream_droid_app/domain/services/event_service.dart';

class MediaViewModel extends ChangeNotifier {
  MediaViewModel() {
    videoController = null;
    _videoPlayer = Player();
    _audioPlayers = List.empty(growable: true);
    _eventService = DependencyManager.getIt<EventService>();
  }
  late EventService _eventService;
  ResponseStream<EventResponse>? _request;
  late VideoController? videoController;
  late List<Player> _audioPlayers;
  late Player _videoPlayer;

  Future<void> initialize() async {
    _videoPlayer.stream.completed.listen((completed) async {
      final currentMediaIndex = _videoPlayer.state.playlist.index;
      final lastMediaIndex = _videoPlayer.state.playlist.medias.length - 1;

      if (currentMediaIndex == lastMediaIndex) {
        videoController = null;
        notifyListeners();
      }

      if (completed) {
        await _videoPlayer.next();
      }
    });

    try {
      _request = _eventService.listen();
      await for (final notification in _request!) {
        if (notification.event.eventType == NotificationEvent_EventType.AUDIO) {
          await playAudio(notification.event);
        } else if (notification.event.eventType ==
            NotificationEvent_EventType.VIDEO) {
          await playVideo(notification.event);
        } else {}
      }
    } on GrpcError catch (error) {
      if (error.code == StatusCode.cancelled) {
        // Stream was cancelled, likely due to disposal. Ignore.
        return;
      } else {
        print('Error receiving event notifications: $error');
      }
    }
  }

  Future<void> playAudio(NotificationEvent notification) async {
    final audioPlayer = Player();
    audioPlayer.stream.completed.listen((completed) async {
      if (completed) {
        await audioPlayer.dispose();
        _audioPlayers.remove(audioPlayer);
      }
    });

    final playable = Media(notification.assetFileEvent.uri);
    await audioPlayer.setVolume(notification.assetFileEvent.volume.toDouble());
    await audioPlayer.open(playable);
    _audioPlayers.add(audioPlayer);
  }

  Future<void> playVideo(NotificationEvent notification) async {
    final playable = Media(notification.assetFileEvent.uri);
    await _videoPlayer.setVolume(notification.assetFileEvent.volume.toDouble());

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
    final closePlayers = _audioPlayers.map((player) => player.stop());
    await Future.wait(closePlayers);
    final disposePlayers = _audioPlayers.map((player) => player.dispose());
    await Future.wait(disposePlayers);
  }

  Future<void> _releaseVideoPlayer() async {
    await _videoPlayer.stop();
    videoController = null;
    await _videoPlayer.dispose();
  }

  @override
  void dispose() {
    _request?.cancel();
    _request = null;
    _releaseAudioPlayers();
    _releaseVideoPlayer();
    super.dispose();
  }
}
