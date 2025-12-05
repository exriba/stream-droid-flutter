import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/domain/services/user_service.dart';
import 'package:stream_droid_app/presentation/viewmodels/dashboard_view_model.dart';
import 'package:stream_droid_app/presentation/viewmodels/media_view_model.dart';
import 'package:stream_droid_app/presentation/viewmodels/redeem_screen_view_model.dart';
import 'package:stream_droid_app/presentation/viewmodels/statistics_view_model.dart';
import 'package:stream_droid_app/presentation/views/dashboard.dart';
import 'package:stream_droid_app/presentation/widgets/navigation_side_bar.dart';
import 'package:stream_droid_app/presentation/views/login.dart';
import 'package:stream_droid_app/presentation/views/media.dart';
import 'package:stream_droid_app/presentation/views/settings.dart';
import 'package:stream_droid_app/presentation/views/redeem_screen.dart';
import 'package:stream_droid_app/presentation/views/statistics.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter routerConfiguration = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: ViewRoute.dashboard.route,
  redirect: (context, state) async {
    final userService = DependencyManager.getIt<UserService>();
    final loginRoute = state.matchedLocation == ViewRoute.login.route;
    final authenticated = await userService.isAuthenticated();

    if (!authenticated && !loginRoute) {
      return ViewRoute.login.route;
    }

    if (authenticated && loginRoute) {
      return ViewRoute.dashboard.route;
    }

    return null;
  },
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return NavigationSideBar(
          view: child,
        );
      },
      routes: [
        GoRoute(
          path: ViewRoute.dashboard.route,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: ChangeNotifierProvider(
                create: (context) {
                  final viewModel = DashboardViewModel();
                  viewModel.loadRedeems();
                  return viewModel;
                },
                child: const Dashboard(),
              ),
            );
          },
        ),
        GoRoute(
          path: ViewRoute.redeems.route,
          pageBuilder: (context, state) {
            final redeemId = state.pathParameters['id'];
            return NoTransitionPage(
              key: state.pageKey,
              child: ChangeNotifierProvider(
                create: (context) {
                  final viewModel = RedeemScreenViewModel(redeemId!);
                  viewModel.loadRedeem();
                  return viewModel;
                },
                child: const RedeemScreen(),
              ),
            );
          },
        ),
        GoRoute(
          path: ViewRoute.media.route,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: ChangeNotifierProvider(
                create: (context) {
                  final viewModel = MediaViewModel();
                  viewModel.initialize();
                  return viewModel;
                },
                child: const Media(),
              ),
            );
          },
        ),
        GoRoute(
          path: ViewRoute.statistics.route,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: ChangeNotifierProvider(
                create: (context) {
                  final viewModel = StatisticsViewModel();
                  viewModel.loadRedeemRedemptions();
                  return viewModel;
                },
                child: const Statistics(),
              ),
            );
          },
        ),
        GoRoute(
          path: ViewRoute.settings.route,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const Settings(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: ViewRoute.login.route,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return const Login();
      },
    ),
  ],
);
