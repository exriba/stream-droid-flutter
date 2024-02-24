import 'package:stream_droid_app/model/preferences.dart';

class User {
  bool authenticathed;
  Preferences preferences;

  User({required this.preferences, this.authenticathed = false});
}
