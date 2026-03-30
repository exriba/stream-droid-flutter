import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_droid_app/src/models/app_feature.dart';
import 'package:stream_droid_app/src/utils/types.dart';
import 'package:stream_droid_app/src/widgets/feature_item.dart';
import 'package:stream_droid_app/src/widgets/login_button.dart';

const String _appIconPath = 'assets/icons/app-icon.png';
const String _twitchLogoPath = 'assets/icons/twitch-logo.svg';
const List<AppFeature> _topFeatures = [
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
];
const List<AppFeature> _bottomFeatures = [
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
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _topFeatures
                  .map(
                    (indicator) => Expanded(
                      child: FeatureItem(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _bottomFeatures
                  .map(
                    (indicator) => Expanded(
                      child: FeatureItem(
                        text: indicator.text,
                        icon: indicator.icon,
                        description: indicator.description,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 50,
              width: 150,
              child: LoginButton(
                assetPath: _twitchLogoPath,
              ),
            ),
          ],
        ),
        Positioned(
          top: -8,
          right: -8,
          child: Padding(
            padding: const EdgeInsetsGeometry.only(
              top: 8,
              right: 8,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.settings_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                context.go(ViewRoute.settings.route);
              },
              style: IconButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
