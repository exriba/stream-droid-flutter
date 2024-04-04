import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/context/theme_context.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/home/home_view.dart';

class App extends StatelessWidget {
  const App({super.key, required this.userContext});
  final UserContext userContext;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => userContext,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeContext.from(context),
        home: const HomeView(),
      ),
    );
  }
}
