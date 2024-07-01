import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather/Models/WeatherModel.dart';

class APIs {
  //https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${APIkey}

  static final String baseUrl = "https://api.openweathermap.org/data/2.5/";
  static final String apiKey = "cd2e34eee5dbf80c8197c24f3701fd7a";

  static Future<Wea> fetch(String city) async {
    final String url =
        baseUrl + "weather?q=${city}&units=metric&appid=${apiKey}";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data =
          Wea.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      return data;
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  static String formatTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    DateFormat formatter = DateFormat('hh:mm a');
    String formattedTime = formatter.format(dateTime);

    return formattedTime;
  }

  static String formatDayOfWeek(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    DateFormat formatter = DateFormat('EEEE');
    String dayOfWeek = formatter.format(dateTime);

    return dayOfWeek;
  }

  static String formatDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    DateFormat formatter = DateFormat('dd MMMM yyyy');
    String formattedDate = formatter.format(dateTime);

    return formattedDate;
  }
}
