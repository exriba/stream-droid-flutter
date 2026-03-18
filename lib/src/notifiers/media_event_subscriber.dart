import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stream_droid_app/src/generated/common/event.pb.dart';
import 'package:stream_droid_app/src/generated/service/eventservice.pb.dart';
import 'package:stream_droid_app/src/providers/media_events.dart';
import 'package:stream_droid_app/src/services/event_service.dart';

part 'media_event_subscriber.g.dart';

@riverpod
class MediaEventSubscriber extends _$MediaEventSubscriber {
  late final EventService _service;
  late final VideoController _videoController;
  final List<Player> _audioPlayers = [];

  StreamSubscription<EventResponse>? _subscription;

  VideoController get controller => _videoController;

  @override
  MediaEventSubscriber build() {
    _service = ref.read(eventServiceProvider);
    _videoController = VideoController(Player());

    _initialize();

    ref.onDispose(() {
      _dispose();
    });

    return this;
  }

  Future<void> _initialize() async {
    await _subscription?.cancel();

    _subscription = _service.subscribe().listen(
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
        if (error is GrpcError && error.code == StatusCode.cancelled) {
          return;
        }

        debugPrint('Error receiving event notifications: $error');
        throw error;
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
    final player = _videoController.player;
    final playable = Media(notification.assetFileEvent.uri);
    final volume = notification.assetFileEvent.volume.toDouble();

    await player.setVolume(volume);

    if (!player.state.playing) {
      await player.open(playable);
      return;
    }

    await player.add(playable);
  }

  Future<void> _dispose() async {
    await _subscription?.cancel();
    _subscription = null;

    await Future.wait(_audioPlayers.map((p) => p.stop()).toList());
    await Future.wait(_audioPlayers.map((p) => p.dispose()).toList());

    await _videoController.player.stop();
    await _videoController.player.dispose();

    _audioPlayers.clear();
  }
}
