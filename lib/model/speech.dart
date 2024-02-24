class Speech {
  final bool enabled;
  final int voiceIndex;

  Speech({required this.enabled, required this.voiceIndex});

  factory Speech.fromJson(Map<String, dynamic> json) => Speech(
        enabled: json['enabled'],
        voiceIndex: json['voiceIndex'],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "voiceIndex": voiceIndex,
      };
}
