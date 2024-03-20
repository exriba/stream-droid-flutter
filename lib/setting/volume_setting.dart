import 'package:flutter/material.dart';

class VolumeSetting extends StatelessWidget {
  const VolumeSetting(
      {super.key,
      this.text,
      this.volume = 0,
      required this.handleVolumeChange});
  final Text? text;
  final double volume;
  final void Function(double value) handleVolumeChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        text ?? const SizedBox.shrink(),
        Slider(
          max: 100,
          divisions: 10,
          value: volume,
          label: volume.round().toString(),
          activeColor: Colors.grey,
          onChanged: (double value) {
            handleVolumeChange(value);
          },
        ),
        const Icon(
          Icons.volume_up,
          color: Color.fromRGBO(225, 225, 225, 1),
        ),
      ],
    );
  }
}
