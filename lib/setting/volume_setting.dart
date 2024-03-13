import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/context/user_context.dart';

class VolumeSetting extends StatelessWidget {
  const VolumeSetting({super.key, this.text});

  final Text? text;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserContext>(builder: (context, userContext, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          text ?? const SizedBox.shrink(),
          Slider(
            max: 100,
            divisions: 10,
            value: userContext.defaultMediaAssetVolume,
            label: userContext.defaultMediaAssetVolume.round().toString(),
            activeColor: Colors.grey,
            onChanged: (double value) {
              userContext.updateDefaultMediaAssetVolume(value);
            },
          ),
          const Icon(
            Icons.volume_up,
            color: Color.fromRGBO(225, 225, 225, 1),
          ),
        ],
      );
    });
  }
}
