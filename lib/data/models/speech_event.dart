import 'package:stream_droid_app/data/models/base_model.dart';

class SpeechEvent extends BaseModel {
  final String id;
  final int volume;
  final String eventType;
  final String message;

  SpeechEvent(
      {required this.id,
      required this.eventType,
      required this.message,
      this.volume = 0});

  factory SpeechEvent.fromJson(Map<String, dynamic> json) => SpeechEvent(
        id: json['id'],
        eventType: json['eventType'],
        message: json['message'],
        volume: json['volume'],
      );

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
