import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'API/api_handler.dart';
import 'API/api_request.dart';

void main() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  runApp(
    App(
      pref: pref,
    ),
  );
}

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

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue, Colors.red],
        ),
      ),
    );
  }
}

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

class CourseMenuScreen extends StatefulWidget {
  final SharedPreferences pref;

  CourseMenuScreen({
    this.pref,
  });

  @override
  _CourseMenuScreenState createState() => _CourseMenuScreenState();
}

class _CourseMenuScreenState extends State<CourseMenuScreen> {
  List<String> enrolled_courses = <String>[];
  Map<String, String> _courses = {
    'ARTIFICIAL INTELLIGENCE': 'CI514',
    'ARTIFICIAL INTELLIGENCE LAB': 'CI574',
    'BASIC NUMERICAL METHODS': '17MA531',
    'BIO-MATERIALS SCIENCE': 'PH534',
    'CELL CULTURE LAB': 'BT571',
    'CELL CULTURE TECHNOLOGY': 'BT511',
    'CLOUD BASED ENTERPRISE SYSTEMS': 'CI521',
    'CLOUD BASED ENTERPRISE SYSTEMS LAB': 'CI581',
    'COMPUTER NETWORKS': 'CI511',
    'COMPUTER NETWORKS LAB': 'CI571',
    'DIGITAL COMMUNICATIONS': 'EC511',
    'DIGITAL COMMUNICATIONS LAB': 'EC571',
    'DISCRETE MATHEMATICS': '16MA531',
    'ELETROMAGNETIC THEORY': 'EC612',
    'ENTREPRENURIAL DEVELOPMENT': '19HS311',
    'ENVIRONMENTAL SCIENCE': 'GE301',
    'FERMENTATION AND DOWNSTREAM LAB': 'BT572',
    'FERMENTATION AND DOWNSTREAM PROCESSING': 'BT512',
    'INDIAN POLITY AND CONSTITUTIONAL DEMOCRACY IN INDIA': 'HS612',
    'INFORMATION SECURITY LAB': 'CI576',
    'IT PRACTICE LAB': '16BT571',
    'LASER TECHNOLOGY AND APPLICATIONS': 'PH533',
    'MATERIALS SCIENCE': 'PH532',
    'MATRIX COMPUTATIONS': 'MA533',
    'MULTIMEDIA LAB': 'CI582',
    'NUCLEAR SCIENCE AND ENGINEERING': 'PH535',
    'OPEN SOURCE SOFTWARE LAB': 'CI575',
    'PLANNING AND ECONOMIC DEVELOPMENT': 'HS532',
    'PLANT TISSUE CULTURE LAB': 'BT573',
    'PRINCIPLES OF MANAGEMENT': 'HS434',
    'QUANTUM MECHANICS FOR ENGINEERS': 'PH531',
    'SOCIOLOGY OF YOUTH': '16HS531',
    'SOFTWARE ENGINEERING': 'CI513',
    'SOFTWARE ENGINEERING LAB': 'CI573',
    'STRATEGIC HUMAN RESOURCE MANAGEMENT': '18HS311',
    'TECHNOLOGY AND CULTURE': '17HS531',
    'THEORY OF NUMBERS': '16MA731',
    'UNIX PROGRAMING LAB': 'CI579',
  };

  Map<String, bool> _boolcoursemap = {
    'ARTIFICIAL INTELLIGENCE': false,
    'ARTIFICIAL INTELLIGENCE LAB': false,
    'BASIC NUMERICAL METHODS': false,
    'BIO-MATERIALS SCIENCE': false,
    'CELL CULTURE LAB': false,
    'CELL CULTURE TECHNOLOGY': false,
    'CLOUD BASED ENTERPRISE SYSTEMS': false,
    'CLOUD BASED ENTERPRISE SYSTEMS LAB': false,
    'COMPUTER NETWORKS': false,
    'COMPUTER NETWORKS LAB': false,
    'DIGITAL COMMUNICATIONS': false,
    'DIGITAL COMMUNICATIONS LAB': false,
    'DISCRETE MATHEMATICS': false,
    'ELETROMAGNETIC THEORY': false,
    'ENTREPRENURIAL DEVELOPMENT': false,
    'ENVIRONMENTAL SCIENCE': false,
    'FERMENTATION AND DOWNSTREAM LAB': false,
    'FERMENTATION AND DOWNSTREAM PROCESSING': false,
    'INDIAN POLITY AND CONSTITUTIONAL DEMOCRACY IN INDIA': false,
    'INFORMATION SECURITY LAB': false,
    'IT PRACTICE LAB': false,
    'LASER TECHNOLOGY AND APPLICATIONS': false,
    'MATERIALS SCIENCE': false,
    'MATRIX COMPUTATIONS': false,
    'MULTIMEDIA LAB': false,
    'NUCLEAR SCIENCE AND ENGINEERING': false,
    'OPEN SOURCE SOFTWARE LAB': false,
    'PLANNING AND ECONOMIC DEVELOPMENT': false,
    'PLANT TISSUE CULTURE LAB': false,
    'PRINCIPLES OF MANAGEMENT': false,
    'QUANTUM MECHANICS FOR ENGINEERS': false,
    'SOCIOLOGY OF YOUTH': false,
    'SOFTWARE ENGINEERING': false,
    'SOFTWARE ENGINEERING LAB': false,
    'STRATEGIC HUMAN RESOURCE MANAGEMENT': false,
    'TECHNOLOGY AND CULTURE': false,
    'THEORY OF NUMBERS': false,
    'UNIX PROGRAMING LAB': false,
  };

  Widget checkbox(String title, bool boolValue) {
    return Checkbox(
      value: boolValue,
      onChanged: (bool value) {
        setState(() {
          _boolcoursemap[title] = value;
          value
              ? enrolled_courses.add(_courses[title])
              : enrolled_courses.remove(_courses[title]);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _snackbar = SnackBar(
      content: Text('You are enrolled to only 8 subjects.'),
      backgroundColor: Colors.deepPurple,
    );
    print(enrolled_courses);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBackground(),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: ListTile(
                  title: Text(
                    "Select your subjects",
                    style: TextStyle(
                      fontFamily: 'Amatic SC',
                      fontSize: 48.0,
                    ),
                  ),
                  trailing: Builder(
                    builder: (context) => InkWell(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          int counter = 0;
                          _boolcoursemap.forEach((String sub, bool issel) {
                            if (issel) {
                              counter++;
                            }
                          });
                          if (counter <= 8) {
                            ApiRequest _user = ApiRequest(
                              widget.pref.getString('batch'),
                              enrolled_courses,
                            );
                            print(_user.toJson());
                            ApiHandler _apiHandler = ApiHandler(req: _user);
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => FutureBuilder(
                                future: _apiHandler.requestServer(),
                                builder: (context, response) {
                                  if (response.hasData) {
                                    widget.pref.setString(
                                        'result', jsonEncode(response.data));
                                    
                                    return Dashboard(
                                      pref: widget.pref,
                                    );
                                  }
                                  return Center(child: CircularProgressIndicator());
                                },
                              ),
                            );
                          } else {
                            Scaffold.of(context).showSnackBar(_snackbar);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: _boolcoursemap.keys.toList().length,
                    itemBuilder: (context, index) {
                      String course = _boolcoursemap.keys.toList()[index];
                      return ListTile(
                        leading: Icon(Icons.book),
                        title: Text(
                          course,
                          style: TextStyle(
                            fontFamily: 'Amatic SC',
                            color: Colors.white,
                            fontSize: 23.0,
                          ),
                        ),
                        trailing: checkbox(course, _boolcoursemap[course]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
