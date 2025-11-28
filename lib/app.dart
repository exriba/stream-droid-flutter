import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/auth/login_view.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/context/theme_context.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/dashboard/dashboard_view.dart';
import 'package:stream_droid_app/layout/navigation_side_bar.dart';
import 'package:stream_droid_app/media/media_view.dart';
import 'package:stream_droid_app/redeem/redeem_view.dart';
import 'package:stream_droid_app/setting/settings_view.dart';
import 'package:stream_droid_app/statistic/statistics_view.dart';
import 'package:toastification/toastification.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter routerConfiguration = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: ViewRoute.dashboard.route,
  redirect: (context, state) async {
    final userContext = context.read<UserContext>();
    final loginRoute = state.matchedLocation == ViewRoute.login.route;
    final authenticated = await userContext.isAuthenticated();

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
              child: const DashboardView(),
            );
          },
        ),
        GoRoute(
          path: ViewRoute.redeems.route,
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'];
            return NoTransitionPage(
              key: state.pageKey,
              child: RedeemView(
                redeemId: id!,
              ),
            );
          },
        ),
        GoRoute(
          path: ViewRoute.media.route,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const MediaView(),
            );
          },
        ),
        GoRoute(
          path: ViewRoute.statistics.route,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const StatisticsView(),
            );
          },
        ),
        GoRoute(
          path: ViewRoute.settings.route,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const SettingsView(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: ViewRoute.login.route,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return const LoginView();
      },
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserContext()),
        ChangeNotifierProvider(create: (_) => ThemeContext())
      ],
      child: MaterialApp.router(
        routerConfig: routerConfiguration,
        debugShowCheckedModeBanner: false,
        theme: ThemeContext.from(context),
        builder: (context, widget) {
          // TODO: Needs a central component for error handling.
          // For now showing toastification, replace later.
          ErrorWidget.builder = (details) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              final message = (details.exception is ClientException)
                  ? 'Unable to reach backend server'
                  : 'An error ocurred';
              toastification.show(
                  context: context,
                  title: Text(message),
                  type: ToastificationType.error,
                  primaryColor: Colors.black,
                  backgroundColor: Colors.red,
                  autoCloseDuration: const Duration(seconds: 3));
            });
            return Container();
          };

          if (widget != null) {
            return widget;
          }

          throw StateError('widget is null');
        },
      ),
    );
  }
}
