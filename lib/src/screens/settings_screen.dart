import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_droid_app/src/providers/hive_storage.dart';
import 'package:stream_droid_app/src/providers/previous_route.dart';
import 'package:stream_droid_app/src/providers/service_control.dart';
import 'package:stream_droid_app/src/widgets/setting_section.dart';
import 'package:stream_droid_app/src/widgets/setting_section_item.dart';
import 'package:stream_droid_app/src/widgets/volume_slider.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

const String mediaLabel = "Media";
const String serviceLabel = "Service";

const String defaultAssetVolumeLabel = "Default asset volume";
const String serviceStatusLabel = "Status";

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late bool status = false;
  late Color color = Colors.red;

  @override
  void initState() {
    super.initState();
    status = false;
    color = Colors.red;
    _checkServiceStatus();
  }

  Future<void> _checkServiceStatus() async {
    final service = ref.read(serviceControlProvider);
    final isRunning = await service.isServiceRunning();
    setState(() {
      status = isRunning;
      color = isRunning ? Colors.green : Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              const SettingSection(
                label: serviceLabel,
              ),
              Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    serviceStatusLabel,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.circle,
                    color: color,
                    size: 18,
                  ),
                ],
              )
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
