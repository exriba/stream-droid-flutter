import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/layout/navigation_layout.dart';
import 'package:stream_droid_app/src/providers/previous_route.dart';
import 'package:stream_droid_app/src/providers/secure_storage.dart';
import 'package:stream_droid_app/src/screens/dashboard_screen.dart';
import 'package:stream_droid_app/src/screens/login_screen.dart';
import 'package:stream_droid_app/src/screens/media_screen.dart';
import 'package:stream_droid_app/src/screens/reward_screen.dart';
import 'package:stream_droid_app/src/screens/settings_screen.dart';
import 'package:stream_droid_app/src/screens/statistics_screen.dart';
import 'package:stream_droid_app/src/utils/types.dart';
import 'package:stream_droid_app/src/layout/main_layout.dart';

class AppRouter {
  static final GoRouter routerConfiguration = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: ViewRoute.root.route,

    routes: [
      ShellRoute(
        builder: (context, state, widget) {
          return MainLayout(
            screen: widget,
          );
        },
        routes: [
          // Login route
          GoRoute(
            path: ViewRoute.login.route,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: const LoginScreen(),
              );
            },
          ),
          GoRoute(
            path: ViewRoute.settings.route,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: const SettingsScreen(),
              );
            },
          ),
          // Layout route with sidebar
          ShellRoute(
            pageBuilder: (context, state, innerWidget) {
              return NoTransitionPage(
                key: state.pageKey,
                child: NavigationLayout(
                  screen: innerWidget,
                ),
              );
            },
            routes: [
              GoRoute(
                path: ViewRoute.root.route,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: const DashboardScreen(),
                  );
                },
              ),
              GoRoute(
                path: ViewRoute.rewards.route,
                pageBuilder: (context, state) {
                  final reward = state.extra as Reward;
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: RewardScreen(reward: reward),
                  );
                },
              ),
              GoRoute(
                path: ViewRoute.media.route,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: const MediaScreen(),
                  );
                },
              ),
              GoRoute(
                path: ViewRoute.statistics.route,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: const StatisticsScreen(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],

    // Global redirect function
    redirect: (context, state) async {
      final container = ProviderScope.containerOf(context);
      final loggingIn = state.matchedLocation == ViewRoute.login.route;
      final routeState = container.read(previousRouteProvider.notifier);
      final secureStorage = container.read(secureStorageProvider);
      final token = await secureStorage.getToken();

      if (state.matchedLocation == ViewRoute.settings.route) {
        return ViewRoute.settings.route;
      }

      routeState.state = state.matchedLocation;

      if (token == null) {
        return loggingIn ? null : ViewRoute.login.route;
      }

      if (loggingIn) {
        return ViewRoute.root.route;
      }

      return null;
    },

    errorBuilder: (context, state) {
      debugPrint('Error: ${state.error}}');
      return Scaffold(
        body: Center(
          child: Text('Page not found: ${state.uri.toString()}'),
        ),
      );
    },
  );
}
