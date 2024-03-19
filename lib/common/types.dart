import 'package:flutter/material.dart';

enum ViewDestination {
  dashboard('Dashboard'),
  statistics('Statistics'),
  media('Media'),
  settings('Settings'),
  login('Login');

  const ViewDestination(this.label);
  final String label;
}

class Preferences {
  ThemeMode themeMode;

  Preferences({this.themeMode = ThemeMode.dark});
}

class User {
  bool authenticathed;
  Preferences preferences;

  User({required this.preferences, this.authenticathed = false});
}

class Redeem {
  final String id;
  final String title;
  final String prompt;
  final String imageUrl;
  final String backgroundColor;
  final String streamerId;
  Speech? speech;

  Redeem(
      {required this.id,
      required this.title,
      required this.prompt,
      required this.imageUrl,
      required this.backgroundColor,
      required this.streamerId,
      this.speech});

  factory Redeem.fromJson(Map<String, dynamic> json) => Redeem(
        id: json['id'],
        title: json['title'],
        prompt: json['prompt'],
        imageUrl: json['imageUrl'],
        backgroundColor: json['backgroundColor'],
        streamerId: json['streamerId'],
        speech:
            json.containsKey('speech') ? Speech.fromJson(json['speech']) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "prompt": prompt,
        "imageUrl": imageUrl,
        "backgroundColor": backgroundColor,
        "streamerId": streamerId,
        "speech": speech?.toJson(),
      };
}

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

class Asset {
  final String id;
  final String fileName;
  int volume;

  Asset({required this.id, required this.fileName, this.volume = 0});

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        id: json['id'],
        fileName: json['fileName'],
        volume: json['volume'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fileName": fileName,
        "volume": volume,
      };
}
