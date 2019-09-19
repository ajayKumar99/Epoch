import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BatchDropDown extends StatefulWidget {
  final SharedPreferences pref;

  const BatchDropDown({
    this.pref,
    Key key,
  }) : super(key: key);

  @override
  _BatchDropDownState createState() => _BatchDropDownState();
}

class _BatchDropDownState extends State<BatchDropDown> {
  String batchdropdownValue = 'A1';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Text(
            "What's your batch?",
            style: TextStyle(
              fontFamily: 'Amatic SC',
              fontSize: 38.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: DropdownButton<String>(
            iconEnabledColor: Colors.white,
            style: TextStyle(
              fontFamily: 'Amatic SC',
              fontSize: 38.0,
              color: Colors.black,
            ),
            value: batchdropdownValue,
            onChanged: (String newValue) {
              setState(() {
                batchdropdownValue = newValue;
                widget.pref.setString('batch', batchdropdownValue);
              });
            },
            items: <String>[
              'A1',
              'A2',
              'A3',
              'A4',
              'A5',
              'A6',
              'A7',
              'A8',
              'A9',
              'A10',
              'B1',
              'B2',
              'B3',
              'B4',
              'B5',
              'B6',
              'B7',
              'B8',
              'B9',
              'B10',
              'B11',
              'B12',
              'B13',
              'B14',
              'C1',
              'C2',
              'C3',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}