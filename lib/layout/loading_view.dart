import 'package:flutter/material.dart';
import 'package:stream_droid_app/layout/app_view.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppView(
      child: Container(
        alignment: Alignment.center,
        color: const Color.fromRGBO(33, 33, 33, 1),
        child: const Align(
            child: CircularProgressIndicator(
          color: Colors.grey,
        )),
      ),
    );
  }
}
