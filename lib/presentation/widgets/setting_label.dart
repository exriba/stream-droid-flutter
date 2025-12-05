import 'package:flutter/material.dart';

class SettingLabel extends StatelessWidget {
  const SettingLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        label,
        style: textStyle,
      ),
    );
  }
}
