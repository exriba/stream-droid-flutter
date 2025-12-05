import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/core/configuration/router.dart';
import 'package:stream_droid_app/core/context/theme_context.dart';
import 'package:stream_droid_app/core/context/user_context.dart';
import 'package:toastification/toastification.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserContext()),
        ChangeNotifierProvider(create: (_) => ThemeContext()),
      ],
      child: MaterialApp.router(
        routerConfig: routerConfiguration,
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
