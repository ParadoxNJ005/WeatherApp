class season {
  static String ani(String type) {
    if (type == "Clear Sky" || type == "Sunny" || type == "Clear") {
      return "sun";
    } else if (type == "Partly Clouds" ||
        type == "Clouds" ||
        type == "Overcast" ||
        type == "Mist" ||
        type == "Foggy" ||
        type == "Haze") {
      return "cloud";
    } else if (type == "Light Rain" ||
        type == "Drizzle" ||
        type == "Moderate Rain" ||
        type == "Showers" ||
        type == "Heavy Rain" ||
        type == "Rain") {
      return "rain";
    } else if (type == "Light Snow" ||
        type == "Moderate Snow" ||
        type == "Heavy Snow" ||
        type == "Blizzed" ||
        type == "Snow") {
      return "snow";
    } else {
      return "cloud";
    }
  }
}
