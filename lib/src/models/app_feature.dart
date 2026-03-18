import 'package:flutter/material.dart';

class AppFeature {
  const AppFeature({
    required this.text,
    required this.icon,
    required this.description,
  });

  final String text;
  final IconData icon;
  final String description;
}
