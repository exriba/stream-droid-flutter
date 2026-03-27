import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stream_droid_app/src/app/app.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/providers/reward.dart';
import 'package:stream_droid_app/src/providers/secure_storage.dart';
import 'package:stream_droid_app/src/screens/dashboard_screen.dart';
import 'package:stream_droid_app/src/screens/login_screen.dart';
import 'package:stream_droid_app/src/services/secure_storage.dart';

class MockSecureStorage extends Mock implements SecureStorage {}

class FakeRewardNotifier extends RewardNotifier {
  FakeRewardNotifier(List<Reward> fakeRewards) : _fakeRewards = fakeRewards;
  final List<Reward> _fakeRewards;

  @override
  Future<List<Reward>> build() async {
    return _fakeRewards;
  }
}

void main() {
  group('App', () {
    late MockSecureStorage mockStorage;

    setUp(() {
      mockStorage = MockSecureStorage();
    });

    testWidgets('redirects to login if token is null', (tester) async {
      // Arrange
      when(() => mockStorage.getToken()).thenAnswer((_) async => null);

      // Wrap App in ProviderScope and override secureStorageProvider
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            secureStorageProvider.overrideWithValue(mockStorage),
          ],
          child: const App(),
        ),
      );

      // Wait for async redirects
      await tester.pumpAndSettle();

      // Assert that LoginScreen is displayed
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(DashboardScreen), findsNothing);
    });

    testWidgets('redirects to dashboard if token exists', (tester) async {
      // Arrange
      when(() => mockStorage.getToken()).thenAnswer((_) async => 'valid_token');

      final container = ProviderContainer(
        overrides: [
          secureStorageProvider.overrideWithValue(mockStorage),
          rewardNotificationProvider.overrideWith(
            () => FakeRewardNotifier(<Reward>[]),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert that DashboardScreen is displayed
      expect(find.byType(DashboardScreen), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
    });
  });
}
