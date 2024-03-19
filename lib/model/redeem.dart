import 'package:stream_droid_app/model/speech.dart';

class Redeem {
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
      required this.speech});

  factory Redeem.fromJson(Map<String, dynamic> json) => Redeem(
        id: json['id'],
        title: json['title'],
        prompt: json['prompt'],
        imageUrl: json['imageUrl'],
        backgroundColor: json['backgroundColor'],
        streamerId: json['streamerId'],
        speech: json['speech'] != null ? Speech.fromJson(json['speech']) : null,
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
