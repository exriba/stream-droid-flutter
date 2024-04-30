import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/setting/setting_label.dart';
import 'package:stream_droid_app/setting/theme_setting.dart';
import 'package:stream_droid_app/setting/volume_setting.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: constraints.maxHeight,
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
              child:
                  Consumer<UserContext>(builder: (context, userContext, child) {
                return VolumeSetting(
                  text: Text(
                    'Default asset volume',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  volume: userContext.defaultMediaAssetVolume,
                  handleVolumeChange: (value) {
                    userContext.updateDefaultMediaAssetVolume(value);
                  },
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
