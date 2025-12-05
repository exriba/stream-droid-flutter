import 'package:stream_droid_app/core/constants/constants.dart' as constants;

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

enum ViewRoute {
  dashboard('/'),
  redeems('/redeems/:id'),
  media('/media'),
  statistics('/statistics'),
  settings('/settings'),
  login('/login');

  const ViewRoute(this.route);
  final String route;
}
