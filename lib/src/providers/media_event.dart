import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:flutter/foundation.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/generated/common/event.pb.dart';
import 'package:stream_droid_app/src/generated/service/eventservice.pb.dart';
import 'package:stream_droid_app/src/providers/auth_interceptor.dart';
import 'package:stream_droid_app/src/providers/client_channel.dart';
import 'package:stream_droid_app/src/services/event_service.dart';

part 'media_event.g.dart';

@riverpod
EventService eventService(EventServiceRef ref) {
  final clientChannel = ref.read(clientChannelProvider);
  final authInterceptor = ref.read(authInterceptorProvider);
  return EventService(clientChannel, authInterceptor);
}

@riverpod
class MediaEvent extends _$MediaEvent {
  MediaEvent() {
    _videoPlayer = Player();
    videoController = VideoController(_videoPlayer);
    _audioPlayers = List.empty(growable: true);
  }
  late StreamSubscription<EventResponse>? _subscription;
  late final List<Player> _audioPlayers;
  late final VideoController videoController;
  late final Player _videoPlayer;

  @override
  Future<void> build() async {
    final service = ref.read(eventServiceProvider);

    ref.onDispose(() async {
      await _subscription?.cancel();
      await _releaseAudioPlayers();
      await _releaseVideoPlayer();
    });

    _subscription = service.subscribe().listen(
      (notification) async {
        switch (notification.event.eventType) {
          case NotificationEvent_EventType.AUDIO:
            await _playAudio(notification.event);
            break;
          case NotificationEvent_EventType.VIDEO:
            await _playVideo(notification.event);
            break;
          default:
            debugPrint('Unsupported type: ${notification.event.eventType}');
            break;
        }
      },
      onError: (error) {
        if (error.code == StatusCode.cancelled) {
          return;
        } else {
          debugPrint('Error receiving event notifications: $error');
          throw error;
        }
      },
      onDone: () {
        debugPrint('Event subscription closed');
      },
    );
  }

  Future<void> _playAudio(NotificationEvent notification) async {
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

  Future<void> _playVideo(NotificationEvent notification) async {
    final playable = Media(notification.assetFileEvent.uri);
    await _videoPlayer.setVolume(notification.assetFileEvent.volume.toDouble());

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
    _audioPlayers.clear();
  }

  Future<void> _releaseVideoPlayer() async {
    await _videoPlayer.stop();
    await _videoPlayer.dispose();
  }
}
