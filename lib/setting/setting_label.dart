import 'package:flutter/material.dart';

class SettingLabel extends StatelessWidget {
  const SettingLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
