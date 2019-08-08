import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

class Dashboard extends StatefulWidget {
  final SharedPreferences pref;

  Dashboard({
    this.pref,
  });

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static DateTime today = DateTime.now();
  int _selectedIndex = today.weekday <= 6 ? today.weekday - 1 : 0;

  Map response;

  List<String> days = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday'
  ];

  @override
  void initState() {
    super.initState();
    response = jsonDecode(widget.pref.getString('result'));
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(response.toString());
    print(_selectedIndex);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            'Epoch',
            style: TextStyle(
              fontFamily: 'Amatic SC',
              fontSize: 48.0,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings_backup_restore),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Reset the App?'),
                  content: Text(
                      'This will completely reset the app clearing all the timetable data and you will have to re-enter everything.'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () {
                        widget.pref.clear();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => App(
                              pref: widget.pref,
                            ),
                          ),
                          ModalRoute.withName(''),
                        );
                      },
                    ),
                    FlatButton(
                      child: Text('No'),
                      onPressed: () => Navigator.pop(
                        context,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: response['result'][days[_selectedIndex]].length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(
                '${response['result'][days[_selectedIndex]][index]['time']}:00 - ${response['result'][days[_selectedIndex]][index]['time'] + response['result'][days[_selectedIndex]][index]['type']['time']}:00',
                style: TextStyle(
                  fontFamily: 'Amatic SC',
                  fontSize: 44.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${response['result'][days[_selectedIndex]][index]['course']} - ${response['result'][days[_selectedIndex]][index]['type']['category']}\n${response['result'][days[_selectedIndex]][index]['faculty']}',
                  style: TextStyle(
                    fontFamily: 'Amatic SC',
                    fontSize: 25.0,
                  ),
                ),
              ),
              trailing: Text(
                '${response['result'][days[_selectedIndex]][index]['room']}',
                style: TextStyle(
                  fontFamily: 'Amatic SC',
                  fontSize: 44.0,
                ),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.cyan,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black12,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            title: Text('MON'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            title: Text('TUE'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            title: Text('WED'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_4),
            title: Text('THUR'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_5),
            title: Text('FRI'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_6),
            title: Text('SAT'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}
