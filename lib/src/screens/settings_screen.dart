import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/providers/hive_storage.dart';
import 'package:stream_droid_app/src/widgets/setting_label.dart';
import 'package:stream_droid_app/src/widgets/volume_setting.dart';
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

    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SettingLabel(
            label: 'Media',
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: VolumeSetting(
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
      ),
    );
  }
}
