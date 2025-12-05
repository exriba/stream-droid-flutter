import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/presentation/viewmodels/media_view_model.dart';

class Media extends StatelessWidget {
  const Media({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MediaViewModel>(builder: (context, viewModel, child) {
      final controller = viewModel.videoController;
      return controller != null
          ? Video(
              controller: controller,
              controls: NoVideoControls,
            )
          : const SizedBox.shrink();
    });
  }
}
