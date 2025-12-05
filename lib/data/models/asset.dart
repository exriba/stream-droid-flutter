import 'package:stream_droid_app/data/enums/media_extension.dart';
import 'package:stream_droid_app/data/models/base_model.dart';

class Asset extends BaseModel {
  final String id;
  final String name;
  final String fileName;
  final MediaExtension extension;
  final int volume;

  Asset(
      {required this.id,
      required this.name,
      required this.fileName,
      required this.extension,
      this.volume = 0});

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        id: json['id'],
        name: json['name'],
        fileName: json['fileName'],
        extension: MediaExtension.fromValue(
          json['extension'],
        ),
        volume: json['volume'],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "fileName": fileName,
        "volume": volume,
      };
}
