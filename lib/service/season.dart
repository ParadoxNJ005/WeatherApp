import 'package:flutter/services.dart';

class season {
  static String ani(String type) {
    type = type.toLowerCase();
    if (type == "clear sky" || type == "sunny" || type == "clear") {
      return "sun";
    } else if (type == "partly clouds" ||
        type == "clouds" ||
        type == "overcast" ||
        type == "mist" ||
        type == "foggy" ||
        type == "haze") {
      return "cloud";
    } else if (type == "light rain" ||
        type == "drizzle" ||
        type == "moderate rain" ||
        type == "showers" ||
        type == "heavy rain" ||
        type == "rain") {
      return "rain";
    } else if (type == "light snow" ||
        type == "moderate snow" ||
        type == "heavy snow" ||
        type == "blizzed" ||
        type == "snow") {
      return "snow";
    } else {
      return "cloud";
    }
  }
}
