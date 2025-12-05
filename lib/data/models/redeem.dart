import 'package:stream_droid_app/data/models/base_model.dart';
import 'package:stream_droid_app/data/models/speech.dart';

class Redeem extends BaseModel {
  final String id;
  final String title;
  final String prompt;
  final String imageUrl;
  final String backgroundColor;
  final String streamerId;
  final Speech? speech;

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

  @override
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
