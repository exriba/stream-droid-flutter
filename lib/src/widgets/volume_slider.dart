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
  late double _volume;
  late IconData _icon;

  @override
  void initState() {
    super.initState();
    _volume = widget.volume;
    _icon = _getIcon(_volume);
  }

  IconData _getIcon(double value) {
    if (value == 0) return Icons.volume_mute_rounded;
    if (value < 50) return Icons.volume_down_rounded;
    return Icons.volume_up_rounded;
  }

  void _handleChange(double value) {
    setState(() {
      _volume = value;
      _icon = _getIcon(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Slider(
          max: 100,
          divisions: 10,
          value: _volume,
          label: _volume.round().toString(),
          activeColor: Colors.grey,
          onChanged: _handleChange,
          onChangeEnd: widget.handleVolumeChange,
        ),
        Icon(
          _icon,
          color: Colors.white,
        ),
      ],
    );
  }
}
