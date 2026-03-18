import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeatureItem extends ConsumerWidget {
  const FeatureItem({
    super.key,
    required this.text,
    required this.icon,
    required this.description,
  });

  final String text;
  final IconData icon;
  final String description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 3,
      children: [
        Icon(
          icon,
          size: 32,
          color: Colors.black,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
