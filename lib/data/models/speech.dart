import 'package:stream_droid_app/data/models/base_model.dart';

class Speech extends BaseModel {
  final bool enabled;
  final int voiceIndex;

  Speech({required this.enabled, this.voiceIndex = 0});

  factory Speech.fromJson(Map<String, dynamic> json) => Speech(
        enabled: json['enabled'],
        voiceIndex: json['voiceIndex'],
      );

  @override
  Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "voiceIndex": voiceIndex,
      };
}
