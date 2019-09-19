import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'api_request.dart';

class ApiHandler {
  final ApiRequest req;

  ApiHandler({
    this.req,
  });

  Future<Map> requestServer() async {
    http.Response res = await http.post(
      'https://jiit-timetable.herokuapp.com/',
      headers: {"Content-Type": "application/json"},
      body: utf8.encode(
        jsonEncode(
          req.toJson(),
        ),
      ),
    ); // post api call
    Map data = json.decode(res.body);
    return data;
  }
}
