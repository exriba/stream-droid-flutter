import 'package:stream_droid_app/data/models/base_model.dart';
import 'package:stream_droid_app/data/models/preferences.dart';

class User extends BaseModel {
  final String id;
  final String name;
  final Preferences preferences;

  User({required this.id, required this.name, required this.preferences});

  factory User.defaultUser() =>
      User(id: '', name: '', preferences: Preferences());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        preferences: Preferences.fromJson(json['preferences']),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "preferences": preferences,
      };
}
