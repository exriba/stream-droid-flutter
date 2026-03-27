import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/utils/hex_color.dart';

void main() {
  const hexColor = '#6441A4';
  const baseColor = Color.fromARGB(255, 100, 65, 164);
  group('HexColor', () {
    test('from Hex', () {
      final color = HexColor.fromHex(hexColor);
      expect(color, baseColor);
    });
  });
}
