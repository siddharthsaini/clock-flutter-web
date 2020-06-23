import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GetTime {
  String hour;
  String min;
  String sec;
  int day;
  String url = "http://worldtimeapi.org/api/timezone/Asia/Kolkata";

  getData() async {
    var response = await http.get(url);
    Map data = jsonDecode(response.body);
    hour = data['datetime'].substring(11, 13);
    min = data['datetime'].substring(14, 16);
    sec = data['datetime'].substring(17, 19);
    day = data['day_of_week'];
    // print('$hour, $min, $sec, $day');
  }
}
