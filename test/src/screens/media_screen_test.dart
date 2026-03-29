import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stream_droid_app/src/providers/media_notification.dart';
import 'package:stream_droid_app/src/screens/media_screen.dart';

class FakePlayerState extends Mock implements PlayerState {
  @override
  bool get playing => false;
  @override
  List<String> get subtitle => <String>[];
}

class FakePlayerStream extends Mock implements PlayerStream {
  @override
  Stream<int?> get width => const Stream.empty();
  @override
  Stream<int?> get height => const Stream.empty();
  @override
  Stream<bool> get playing => const Stream.empty();
  @override
  Stream<List<String>> get subtitle => const Stream.empty();
}

class FakePlayer extends Mock implements Player {
  @override
  PlayerState get state => FakePlayerState();
  @override
  PlayerStream get stream => FakePlayerStream();
}

class FakeVideoController extends Mock implements VideoController {
  @override
  Player get player => FakePlayer();
  @override
  ValueNotifier<PlatformVideoController?> get notifier => ValueNotifier(null);
}

class FakeEventNotifier extends EventNotifier {
  @override
  VideoController build() {
    return FakeVideoController();
  }
}

void main() {
  group('MediaScreen', () {
    testWidgets('renders video widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProviderScope(
            overrides: [
              eventNotificationProvider.overrideWith(
                () => FakeEventNotifier(),
              ),
            ],
            child: const MediaScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Video), findsOneWidget);
    });
  });
}
