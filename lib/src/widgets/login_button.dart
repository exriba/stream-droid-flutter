import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_droid_app/src/utils/types.dart';
import 'package:stream_droid_app/src/providers/user.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key, required this.assetPath});
  final String assetPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.read(userServiceProvider);

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 8,
        shadowColor: Colors.black,
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: SvgPicture.asset(
        assetPath,
        height: 30,
        width: 30,
        colorFilter: const ColorFilter.mode(
          Colors.black,
          BlendMode.srcIn,
        ),
      ),
      label: const Text(
        'Login',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: 1.2,
        ),
      ),
      onPressed: () async {
        final authenticated = await service.login();
        if (authenticated && context.mounted) {
          context.go(ViewRoute.dashboard.route);
        }
      },
    );
  }
}
