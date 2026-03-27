import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stream_droid_app/src/services/secure_storage.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

// Mock Secure Storage
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('SecureStorage', () {
    late MockFlutterSecureStorage mockStorage;
    late SecureStorage storage;

    const testToken = 'my_secret_token';

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      storage = SecureStorage(mockStorage);
    });

    test('getToken returns stored token', () async {
      // Arrange
      when(() => mockStorage.read(key: constants.appName))
          .thenAnswer((_) async => testToken);

      // Act
      final result = await storage.getToken();

      // Assert
      expect(result, testToken);
      verify(() => mockStorage.read(key: constants.appName)).called(1);
    });

    test('saveToken writes token to storage', () async {
      // Arrange
      when(() => mockStorage.write(key: constants.appName, value: testToken))
          .thenAnswer((_) async => Future.value());

      // Act
      await storage.saveToken(token: testToken);

      // Assert
      verify(() => mockStorage.write(key: constants.appName, value: testToken))
          .called(1);
    });

    test('deleteToken removes token from storage', () async {
      // Arrange
      when(() => mockStorage.delete(key: constants.appName))
          .thenAnswer((_) async => Future.value());

      // Act
      await storage.deleteToken();

      // Assert
      verify(() => mockStorage.delete(key: constants.appName)).called(1);
    });
  });
}
