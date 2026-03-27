import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/utils/types.dart';

void main() {
  group('ViewRoute', () {
    test('returns dashboard route', () {
      expect(ViewRoute.dashboard.route, '/');
    });
    test('returns rewards route', () {
      expect(ViewRoute.rewards.route, '/rewards');
    });
    test('returns media route', () {
      expect(ViewRoute.media.route, '/media');
    });
    test('returns statistics route', () {
      expect(ViewRoute.statistics.route, '/statistics');
    });
    test('returns settings route', () {
      expect(ViewRoute.settings.route, '/settings');
    });
    test('returns login route', () {
      expect(ViewRoute.login.route, '/login');
    });
  });
}
