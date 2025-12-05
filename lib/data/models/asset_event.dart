import 'package:stream_droid_app/data/models/base_model.dart';

class AssetEvent extends BaseModel {
  final String id;
  final int volume;
  final String eventType;
  final String uri;

  AssetEvent(
      {required this.id,
      required this.eventType,
      required this.uri,
      this.volume = 0});

  factory AssetEvent.fromJson(Map<String, dynamic> json) => AssetEvent(
        id: json['Id'],
        eventType: json['EventType'],
        uri: json['Uri'],
        volume: json['Volume'],
      );

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
