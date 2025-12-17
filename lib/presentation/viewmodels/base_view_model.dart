import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  late bool disposed = false;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}
