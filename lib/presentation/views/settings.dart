import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/core/context/preference_context.dart';
import 'package:stream_droid_app/presentation/widgets/setting_label.dart';
import 'package:stream_droid_app/presentation/widgets/theme_setting.dart';
import 'package:stream_droid_app/presentation/widgets/volume_setting.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SettingLabel(label: 'Application'),
          const Divider(
            indent: 10,
            endIndent: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ThemeSetting(
              text: Text(
                'Background color',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          const SettingLabel(label: 'Media'),
          const Divider(
            indent: 10,
            endIndent: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Consumer<PreferenceContext>(
                builder: (context, preferenceContext, child) {
              return VolumeSetting(
                text: Text(
                  'Default asset volume',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                volume: preferenceContext.defaultMediaAssetVolume,
                handleVolumeChange: (value) {
                  preferenceContext.updateDefaultMediaAssetVolume(value);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
