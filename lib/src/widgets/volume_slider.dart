import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VolumeSlider extends ConsumerStatefulWidget {
  const VolumeSlider({
    super.key,
    this.volume = 0,
    required this.handleVolumeChange,
  });
  final double volume;
  final Future<void> Function(double value) handleVolumeChange;

  @override
  ConsumerState<VolumeSlider> createState() => _VolumeSetting();
}

class _VolumeSetting extends ConsumerState<VolumeSlider> {
  IconData iconData = Icons.volume_mute_rounded;
  double volume = 0;

  @override
  void initState() {
    super.initState();
    _handleChange(widget.volume);
  }

  void _handleChange(double value) {
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
      children: [
        Slider(
          max: 100,
          divisions: 10,
          value: volume,
          label: volume.round().toString(),
          activeColor: Colors.grey,
          onChanged: _handleChange,
          onChangeEnd: (value) async {
            await widget.handleVolumeChange(value);
          },
        ),
        Icon(
          iconData,
          color: Colors.white,
        ),
      ],
    );
  }
}
