import 'package:flutter/material.dart';

class VolumeSetting extends StatelessWidget {
  const VolumeSetting(
      {super.key,
      this.text,
      this.volume = 0,
      this.alignment = MainAxisAlignment.end,
      required this.handleVolumeChange});
  final Text? text;
  final double volume;
  final MainAxisAlignment alignment;
  final void Function(double value) handleVolumeChange;

  @override
  Widget build(BuildContext context) {
    final iconData = volume == 0
        ? Icons.volume_mute_rounded
        : volume < 50
            ? Icons.volume_down_rounded
            : Icons.volume_up_rounded;

    return Row(
      mainAxisAlignment: alignment,
      children: [
        text ?? const SizedBox.shrink(),
        Slider(
          max: 100,
          divisions: 10,
          value: volume,
          label: volume.round().toString(),
          activeColor: Colors.grey,
          onChanged: (double value) => handleVolumeChange(value),
        ),
        Icon(
          iconData,
          color: const Color.fromRGBO(225, 225, 225, 1),
        ),
      ],
    );
  }
}
