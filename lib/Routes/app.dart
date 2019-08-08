import 'mainscreen.dart';
import 'dashboard.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  final SharedPreferences pref;

  App({
    this.pref,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.deepOrangeAccent,
        primaryColor: Colors.deepOrange,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: pref.containsKey('result')
              ? Dashboard(
                  pref: pref,
                )
              : MainScreen(
                  pref: pref,
                ),
        ),
      ),
    );
  }
}