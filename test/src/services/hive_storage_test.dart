import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive/hive.dart';
import 'package:stream_droid_app/src/services/hive_storage.dart';

// Mock Hive Box
class MockBox extends Mock implements Box {}

void main() {
  group('HiveStorage', () {
    late HiveStorage storage;
    late MockBox mockBox;

    setUp(() {
      mockBox = MockBox();
      storage = HiveStorage(mockBox);
    });

    test('set calls box.put with correct key and value', () async {
      const key = 'username';
      const value = 'JohnDoe';

      when(() => mockBox.put(key, value))
          .thenAnswer((_) async => Future.value());

      await storage.set(key, value);

      verify(() => mockBox.put(key, value)).called(1);
    });

    test('get returns the value from box', () {
      const key = 'username';
      const value = 'JohnDoe';

      when(() => mockBox.get(key, defaultValue: null)).thenReturn(value);

      final result = storage.get<String>(key);

      expect(result, value);
      verify(() => mockBox.get(key, defaultValue: null)).called(1);
    });

    test('get returns default value if key not in box', () {
      const key = 'nonexistent';
      const defaultValue = 'DefaultUser';

      when(() => mockBox.get(key, defaultValue: defaultValue))
          .thenReturn(defaultValue);

      final result = storage.get<String>(key, defaultValue: defaultValue);

      expect(result, defaultValue);
      verify(() => mockBox.get(key, defaultValue: defaultValue)).called(1);
    });
  });
}
