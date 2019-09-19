import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/api_handler.dart';
import '../API/api_request.dart';
import '../Widgets/gradient_background.dart';
import 'dashboard.dart';


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