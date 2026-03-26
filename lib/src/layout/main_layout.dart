import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_droid_app/src/models/app_bar_action.dart';
import 'package:stream_droid_app/src/providers/global_error.dart';
import 'package:stream_droid_app/src/providers/user.dart';
import 'package:stream_droid_app/src/utils/types.dart';

class MainLayout extends ConsumerWidget {
  const MainLayout({super.key, required this.screen});
  final Widget screen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error = ref.watch(globalErrorProvider);

    if (error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final scaffolMessenger = ScaffoldMessenger.of(context);
        if (scaffolMessenger.mounted) {
          scaffolMessenger.hideCurrentSnackBar();
        }
        scaffolMessenger.showSnackBar(
          SnackBar(
            content: Row(
              spacing: 10,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
                Expanded(
                  child: Text(
                    error,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            action: SnackBarAction(
              label: "Close",
              textColor: Colors.white,
              onPressed: () {
                scaffolMessenger.hideCurrentSnackBar();
              },
            ),
            duration: const Duration(
              days: 1,
            ),
          ),
        );
        final errorProvider = ref.read(globalErrorProvider.notifier);
        errorProvider.state = null;
      });
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple,
            Colors.purpleAccent,
            Colors.deepPurple,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: screen,
    );
  }
}
