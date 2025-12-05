import 'package:stream_droid_app/data/models/base_model.dart';

class Preferences extends BaseModel {
  final int defaultVolume;

  Preferences({this.defaultVolume = 0});

  factory Preferences.fromJson(Map<String, dynamic> json) => Preferences(
        defaultVolume: json['defaultVolume'],
      );

  @override
  Map<String, dynamic> toJson() => {
        "defaultVolume": defaultVolume,
      };
}
