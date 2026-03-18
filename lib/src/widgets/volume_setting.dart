import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VolumeSetting extends ConsumerStatefulWidget {
  const VolumeSetting({
    super.key,
    this.text,
    this.volume = 0,
    this.alignment = MainAxisAlignment.end,
    required this.handleVolumeChange,
  });
  final Text? text;
  final double volume;
  final MainAxisAlignment alignment;
  final void Function(double value) handleVolumeChange;

  @override
  ConsumerState<VolumeSetting> createState() => _VolumeSetting();
}

class _VolumeSetting extends ConsumerState<VolumeSetting> {
  double volume = 0;
  IconData iconData = Icons.volume_mute_rounded;

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
          color: Colors.white,
        ),
      ],
    );
  }
}
