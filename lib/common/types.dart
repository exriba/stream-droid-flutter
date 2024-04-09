import 'package:stream_droid_app/common/constants.dart' as constants;

enum UrlFragment {
  // ======================== User Routes ========================
  me,
  meLogin,
  meLogout,
  mePreferences,
  // ======================== Reward Routes ========================
  rewards,
  rewardsSync,
  reward,
  rewardSpeech,
  rewardAssets,
  // ======================== Redemptions Routes ========================
  redemptions,
  redemption;

  Uri getFragment({String? id}) {
    const baseUrl = constants.serverBaseAddress;
    return switch (this) {
      UrlFragment.me => Uri.parse("$baseUrl/me"),
      UrlFragment.meLogin => Uri.parse("$baseUrl/login"),
      UrlFragment.meLogout => Uri.parse("$baseUrl/logout"),
      UrlFragment.mePreferences => Uri.parse("$baseUrl/me/preferences"),
      UrlFragment.rewards => Uri.parse("$baseUrl/rewards"),
      UrlFragment.rewardsSync => Uri.parse("$baseUrl/rewards/sync"),
      UrlFragment.reward => Uri.parse("$baseUrl/rewards/$id"),
      UrlFragment.rewardSpeech => Uri.parse("$baseUrl/rewards/$id/speech"),
      UrlFragment.rewardAssets => Uri.parse("$baseUrl/rewards/$id/assets"),
      UrlFragment.redemptions => Uri.parse("$baseUrl/redemptions"),
      UrlFragment.redemption => Uri.parse("$baseUrl/redemptions/reward/$id"),
    };
  }
}

enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE');

  const HttpMethod(this.method);
  final String method;
}

enum ViewDestination {
  dashboard('Dashboard'),
  statistics('Statistics'),
  media('Media'),
  settings('Settings'),
  login('Login');

  const ViewDestination(this.label);
  final String label;
}

enum MediaExtension {
  mp3('MP3'),
  mp4('MP4');

  const MediaExtension(this.extension);
  final String extension;

  static MediaExtension fromValue(String value) {
    return MediaExtension.values
        .firstWhere((element) => element.extension == value);
  }
}

abstract class _BaseModel {
  Map<String, dynamic> toJson();
}

class Preferences extends _BaseModel {
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

class User extends _BaseModel {
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

class Redeem extends _BaseModel {
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

class RedeemRedemption extends _BaseModel {
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

class Speech extends _BaseModel {
  final bool enabled;
  final int voiceIndex;

  Speech({required this.enabled, this.voiceIndex = 0});

  factory Speech.fromJson(Map<String, dynamic> json) => Speech(
        enabled: json['enabled'],
        voiceIndex: json['voiceIndex'],
      );

  @override
  Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "voiceIndex": voiceIndex,
      };
}

class Asset extends _BaseModel {
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

class SpeechEvent extends _BaseModel {
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

class AssetEvent extends _BaseModel {
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
