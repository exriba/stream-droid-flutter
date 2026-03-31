import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeatureSwitch extends ConsumerWidget {
  const FeatureSwitch({
    super.key,
    required this.enabled,
    required this.onChanged,
  });
  final bool enabled;
  final Future<void> Function(bool) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Switch(
      value: enabled,
      activeThumbColor: Colors.black,
      onChanged: (value) async {
        await onChanged(value);
      },
    );
  }
}
