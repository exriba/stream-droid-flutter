import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/widgets/login_button.dart';

void main() {
  group('LoginButton', () {
    testWidgets('renders', (tester) async {
      const appIconPath = 'assets/icons/app-icon.png';

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginButton(
              assetPath: appIconPath,
            ),
          ),
        ),
      );

      expect(find.text('Login'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
