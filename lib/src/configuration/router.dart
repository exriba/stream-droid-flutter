import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_droid_app/src/providers/user.dart';
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
    initialLocation: ViewRoute.dashboard.route,

    routes: [
      ShellRoute(
        builder: (context, state, outerChild) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple,
                  Colors.purpleAccent,
                  Colors.deepPurple,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: outerChild,
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
          // Layout route with sidebar
          ShellRoute(
            pageBuilder: (context, state, innerChild) {
              return NoTransitionPage(
                key: state.pageKey,
                child: MainLayout(
                  screen: innerChild,
                ),
              );
            },
            routes: [
              GoRoute(
                path: ViewRoute.dashboard.route,
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
                  final rewardId = state.pathParameters['id'];
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: RewardScreen(rewardId: rewardId!),
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
              GoRoute(
                path: ViewRoute.settings.route,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: const SettingsScreen(),
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
      final service = container.read(userControllerProvider);
      bool authenticated = false;

      try {
        authenticated = await service.isAuthenticated();
      } catch (e) {
        debugPrint('Error checking authentication: $e');
      }

      return authenticated ? null : ViewRoute.login.route;
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
