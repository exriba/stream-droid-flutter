import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/context/theme_context.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/home/home_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserContext(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, widget) {
          ErrorWidget.builder = (details) {
            return Align(
              child: Text(
                'Something went wrong.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          };

          if (widget != null) {
            return widget;
          }

          throw StateError('widget is null');
        },
        theme: ThemeContext.from(context),
        home: const HomeView(),
      ),
    );
  }
}
