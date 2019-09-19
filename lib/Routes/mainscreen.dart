import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/batch_dropdown.dart';
import '../Widgets/gradient_background.dart';
import 'coursemenu_screen.dart';


class MainScreen extends StatelessWidget {
  final SharedPreferences pref;

  const MainScreen({
    this.pref,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new GradientBackground(),
        Positioned(
          top: 50.0,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Epoch',
              style: TextStyle(
                fontSize: 88.0,
                fontFamily: 'Amatic SC',
                color: Colors.white,
              ),
            ),
          ),
        ),
        new BatchDropDown(
          pref: pref,
        ),
        Positioned(
          bottom: 50.0,
          child: IconButton(
            iconSize: 48.0,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return CourseMenuScreen(
                    pref: pref,
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}