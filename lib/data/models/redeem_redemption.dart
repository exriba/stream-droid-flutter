import 'package:stream_droid_app/data/models/base_model.dart';

class RedeemRedemption extends BaseModel {
  final String id;
  final String name;
  final String color;
  final double number;

  RedeemRedemption(
      {required this.id,
      required this.name,
      required this.color,
      required this.number});

  factory RedeemRedemption.fromJson(Map<String, dynamic> json) =>
      RedeemRedemption(
        id: json['id'],
        name: json['name'],
        color: json['fill'],
        number: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "fill": color,
        "number": number,
      };
}
