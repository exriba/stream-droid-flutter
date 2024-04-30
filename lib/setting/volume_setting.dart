import 'package:flutter/material.dart';

class VolumeSetting extends StatefulWidget {
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
  State<StatefulWidget> createState() => _VolumeSetting();
}

class _VolumeSetting extends State<VolumeSetting> {
  double volume = 0;
  IconData iconData = Icons.volume_mute_rounded;
  final volumeIconColor = const Color.fromRGBO(225, 225, 225, 1);

  @override
  void initState() {
    super.initState();
    handleChange(widget.volume);
  }

  void handleChange(double value) {
    setState(() {
      volume = value;
      iconData = value == 0
          ? Icons.volume_mute_rounded
          : value < 50
              ? Icons.volume_down_rounded
              : Icons.volume_up_rounded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.alignment,
      children: [
        widget.text ?? const SizedBox.shrink(),
        Slider(
          max: 100,
          divisions: 10,
          value: volume,
          label: volume.round().toString(),
          activeColor: Colors.grey,
          onChanged: handleChange,
          onChangeEnd: widget.handleVolumeChange,
        ),
        Icon(
          iconData,
          color: volumeIconColor,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
