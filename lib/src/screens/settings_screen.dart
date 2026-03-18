import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/providers/hive_storage.dart';
import 'package:stream_droid_app/src/widgets/volume_slider.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.read(hiveStorageProvider);
    final volume = storage.get<double>(
      constants.defaultVolumeKey,
      defaultValue: 50,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Media',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(
          color: Colors.black,
          endIndent: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: VolumeSlider(
            text: const Text(
              'Default asset volume',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            volume: volume,
            handleVolumeChange: (volume) async {
              await storage.set(constants.defaultVolumeKey, volume);
            },
          ),
        ),
      ],
    );
  }
}
