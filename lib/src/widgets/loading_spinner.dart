import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingSpinner extends ConsumerWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.grey,
      ),
    );
  }
}
