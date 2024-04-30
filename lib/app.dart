import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/context/theme_context.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/home/home_view.dart';
import 'package:stream_droid_app/layout/custom_app_bar.dart';
import 'package:toastification/toastification.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserContext()),
        ChangeNotifierProvider(create: (_) => ThemeContext())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
        theme: ThemeContext.from(context),
        home: Scaffold(
          backgroundColor: Colors.grey[700],
          appBar: const CustomAppBar(),
          body: Consumer<ThemeContext>(builder: (context, themeContext, child) {
            return Container(
              margin: const EdgeInsets.only(left: 2, right: 2, bottom: 2),
              color: themeContext.backgroundColor,
              child: const HomeView(),
            );
          }),
        ),
      ),
    );
  }
}
