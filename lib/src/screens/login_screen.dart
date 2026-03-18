import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/models/app_feature.dart';
import 'package:stream_droid_app/src/widgets/app_feature_indicator.dart';
import 'package:stream_droid_app/src/widgets/login_button.dart';

const String _appIconPath = 'assets/icons/app-icon.png';
const String _twitchLogoPath = 'assets/icons/twitch-logo.svg';
const List<AppFeature> _featureIndicators = [
  AppFeature(
    text: "Dashboard",
    icon: Icons.dashboard_outlined,
    description: "View and manage your channel rewards.",
  ),
  AppFeature(
    text: "Real-Time",
    icon: Icons.live_tv_outlined,
    description: "Receive live events from engaged viewers.",
  ),
  AppFeature(
    text: "Statistics",
    icon: Icons.show_chart_outlined,
    description: "View analytics about your channel redeems.",
  ),
  AppFeature(
    text: "Customization",
    icon: Icons.settings_outlined,
    description: "Customize your preferences and settings.",
  ),
];

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _featureIndicators
                .map(
                  (indicator) => Expanded(
                    child: AppFeatureIndicator(
                      text: indicator.text,
                      icon: indicator.icon,
                      description: indicator.description,
                    ),
                  ),
                )
                .toList(),
          ),
          Image.asset(
            _appIconPath,
            height: 128,
            width: 128,
            color: Colors.black,
          ),
          const SizedBox(
            height: 50,
            width: 150,
            child: LoginButton(assetPath: _twitchLogoPath),
          ),
        ],
      ),
    );
  }
}
