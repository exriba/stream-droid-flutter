import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingSectionItem extends ConsumerWidget {
  const SettingSectionItem({
    super.key,
    required this.label,
    required this.item,
    this.alignment = MainAxisAlignment.end,
  });
  final String label;
  final Widget item;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        item,
      ],
    );
  }
}
