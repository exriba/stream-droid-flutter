import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_droid_app/src/providers/hive_storage.dart';
import 'package:stream_droid_app/src/providers/previous_route.dart';
import 'package:stream_droid_app/src/widgets/setting_section.dart';
import 'package:stream_droid_app/src/widgets/setting_section_item.dart';
import 'package:stream_droid_app/src/widgets/volume_slider.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

const String mediaLabel = "Media";
const String defaultAssetVolumeLabel = "Default asset volume";

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final previous = ref.read(previousRouteProvider);
    final storage = ref.read(hiveStorageProvider);
    final volume = storage.get<double>(
      constants.defaultVolumeKey,
      defaultValue: 50,
    );

    return Container(
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Column(
            children: [
              const SettingSection(
                label: mediaLabel,
              ),
              SettingSectionItem(
                label: defaultAssetVolumeLabel,
                item: VolumeSlider(
                  volume: volume,
                  handleVolumeChange: (volume) async {
                    await storage.set(constants.defaultVolumeKey, volume);
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: -8,
            right: -8,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                final router = GoRouter.of(context);
                context.go(previous, extra: router.state.extra);
              },
              style: IconButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
