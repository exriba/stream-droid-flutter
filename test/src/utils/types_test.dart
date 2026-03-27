import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/utils/types.dart';

void main() {
  group('ViewRoute', () {
    test('ensures all routes map to the right values', () {
      final cases = {
        ViewRoute.dashboard: '/',
        ViewRoute.rewards: '/rewards',
        ViewRoute.media: '/media',
        ViewRoute.settings: '/settings',
        ViewRoute.statistics: '/statistics',
        ViewRoute.login: '/login',
      };

      for (final entry in cases.entries) {
        expect(entry.key.route, entry.value);
      }
    });
  });
}
