import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stream_droid_app/src/app/app.dart';
import 'package:stream_droid_app/src/generated/common/redeem.pb.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/providers/hive_storage.dart';
import 'package:stream_droid_app/src/providers/redeem.dart';
import 'package:stream_droid_app/src/providers/reward.dart';
import 'package:stream_droid_app/src/providers/secure_storage.dart';
import 'package:stream_droid_app/src/screens/dashboard_screen.dart';
import 'package:stream_droid_app/src/screens/login_screen.dart';
import 'package:stream_droid_app/src/screens/media_screen.dart';
import 'package:stream_droid_app/src/screens/settings_screen.dart';
import 'package:stream_droid_app/src/screens/statistics_screen.dart';
import 'package:stream_droid_app/src/services/hive_storage.dart';
import 'package:stream_droid_app/src/services/secure_storage.dart';

class MockSecureStorage extends Mock implements SecureStorage {}

class MockHiveStorage extends Mock implements HiveStorage {}

class FakeRewardNotifier extends RewardNotifier {
  @override
  Future<List<Reward>> build() async {
    return <Reward>[];
  }
}

class FakeRedeemNotifier extends RedeemNotifier {
  @override
  Future<List<RewardRedeem>> build() async {
    return <RewardRedeem>[];
  }
}

void main() {
  group('App', () {
    late ProviderContainer container;
    late MockSecureStorage mockStorage;
    late MockHiveStorage mockHiveStorage;

    setUp(() {
      mockStorage = MockSecureStorage();
      mockHiveStorage = MockHiveStorage();
      container = ProviderContainer(
        overrides: [
          secureStorageProvider.overrideWithValue(mockStorage),
          hiveStorageProvider.overrideWithValue(mockHiveStorage),
          rewardNotificationProvider.overrideWith(
            () => FakeRewardNotifier(),
          ),
          redeemNotificationProvider.overrideWith(
            () => FakeRedeemNotifier(),
          ),
        ],
      );

      when(() => mockStorage.getToken()).thenAnswer((_) async => 'valid_token');

      when(
        () => mockHiveStorage.get<double>(
          any(),
          defaultValue: any(named: 'defaultValue'),
        ),
      ).thenAnswer((_) => 50);
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('renders login screen if token is null', (tester) async {
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

    testWidgets('renders dashboard screen if token exists', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const App(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsNothing);
      expect(find.byType(DashboardScreen), findsOneWidget);
    });

    testWidgets('renders media screen', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const App(),
        ),
      );

      await tester.pumpAndSettle();

      final nagivationbutton = find.byIcon(Icons.live_tv_outlined);

      await tester.tap(nagivationbutton);
      await tester.pumpAndSettle();

      expect(find.byType(MediaScreen), findsOneWidget);
    });

    testWidgets('renders statistics screen', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const App(),
        ),
      );

      await tester.pumpAndSettle();

      final nagivationbutton = find.byIcon(Icons.show_chart_outlined);

      await tester.tap(nagivationbutton);
      await tester.pumpAndSettle();

      expect(find.byType(StatisticsScreen), findsOneWidget);
    });

    testWidgets('renders settings screen', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const App(),
        ),
      );

      await tester.pumpAndSettle();

      final nagivationbutton = find.byIcon(Icons.settings_outlined);

      await tester.tap(nagivationbutton);
      await tester.pumpAndSettle();

      expect(find.byType(SettingsScreen), findsOneWidget);
    });
  });
}
