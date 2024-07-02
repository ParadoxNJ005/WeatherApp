import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/Models/WeatherModel.dart';
import 'package:weather/service/apis.dart';
import 'package:weather/service/season.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  Future<Wea>? _weatherData;
  String lastsearch = "Jaipur";
  final _formKey = GlobalKey<FormState>();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weatherData = APIs.fetch("sikkim");
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: FutureBuilder<Wea>(
              future: _weatherData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  log("Error: ${snapshot.error}");
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final weather = snapshot.data!;
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/${season.ani(weather.weather[0].description.toString())}.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: mq.height * 0.052,
                          child: Column(
                            children: [
                              search(mq, weather),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black,
                                    size: mq.height * .04,
                                  ),
                                  Text(
                                    weather.name,
                                    style: TextStyle(
                                        fontSize: mq.height * .03,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              weatherRow(mq, weather),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                APIs.formatDayOfWeek(weather.sys.sunrise),
                                style: TextStyle(
                                    fontSize: mq.height * .025,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                APIs.formatDate(weather.sys.sunrise),
                                style: TextStyle(
                                    fontSize: mq.height * .025,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              details(mq, weather),
                              SizedBox(
                                height: mq.height * 0.04,
                              ),
                              Text(
                                "Designed By \n     Naitik",
                                style: TextStyle(
                                    fontSize: mq.height * 0.02,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Text("No data");
                }
              }),
        ),
      ),
    );
  }

  Widget search(Size mq, Wea weather) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSearching = !_isSearching;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: mq.height * 0.05,
          width: mq.width * 0.9,
          color: Colors.white,
          child: Row(
            children: [
              // Search icon
              if (!_isSearching)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.search),
                ),
              // City name or search text field
              Expanded(
                child: _isSearching
                    ? Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'City name ...',
                            ),
                            autofocus: true,
                            onChanged: (val) {}),
                      )
                    : Text(
                        '${weather.name}',
                        style: TextStyle(fontSize: mq.height * 0.03),
                      ),
              ),
              _isSearching
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          onPressed: () async {
                            if (_searchController.text.isEmpty) {
                              APIs.showSnackbar(
                                  context, "City name cannot be empty");
                            } else {
                              try {
                                final weather =
                                    await APIs.fetch(_searchController.text);
                                setState(() {
                                  lastsearch = _searchController.text;
                                  _weatherData = Future.value(weather);
                                  _isSearching = false;
                                });
                              } catch (e) {
                                _searchController.clear();
                                setState(() {
                                  _isSearching = !_isSearching;
                                  APIs.showSnackbar(context, "City Not Found");
                                });
                              }
                            }
                          },
                          icon: Icon(Icons.logout)),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget weatherRow(Size mq, Wea weather) {
    return Container(
      width: mq.width,
      padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //----------------weather animation-----//
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/${season.ani(weather.weather[0].description.toString())}.json',
                    width: mq.width * 1,
                    height: mq.height * 0.2,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text('${weather.weather[0].description.toString()}',
                      style: TextStyle(
                          fontSize: mq.height * 0.04,
                          fontWeight: FontWeight.w500)),
                )
              ],
            ),
          ),

          //-----------------current data------------------------//
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(
                    "Today",
                    style: TextStyle(
                      fontSize: mq.height * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                //-------------current temperature-------------------------//

                Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: weather.main.temp.round().toString(),
                            style: TextStyle(
                              fontSize: mq.height * 0.12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(0, -25),
                              child: Text(
                                "°C",
                                textScaleFactor: 0.7,
                                style: TextStyle(
                                  fontSize: mq.height * 0.08,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    //-
                    ),

                //------------Min and Max temperature----------------------//

                Column(
                  children: [
                    //----min temp-----------//
                    Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Min: ${weather.main.tempMin}",
                                style: TextStyle(
                                  fontSize: mq.height * 0.027,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(0, -5),
                                  child: Text(
                                    "°C",
                                    textScaleFactor: 0.7,
                                    style: TextStyle(
                                      fontSize: mq.height * 0.02,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        //-
                        ),

                    //-----------max temp----------//
                    Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Max: ${weather.main.tempMax}",
                                style: TextStyle(
                                  fontSize: mq.height * 0.027,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(0, -5),
                                  child: Text(
                                    "°C",
                                    textScaleFactor: 0.7,
                                    style: TextStyle(
                                      fontSize: mq.height * 0.02,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        //-
                        ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget details(Size mq, Wea weather) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 250,
        width: mq.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          color: Color.fromRGBO(255, 255, 255, 0.5),
        ),

        //--------------details column-------------------------//
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //-----detail row1----------------------------//
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //---humidity-----//
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 110,
                      width: mq.width * 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        color: Color.fromRGBO(255, 255, 255, 0.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/humidity.svg",
                            height: mq.height * .04,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            weather.main.humidity.toString(),
                            style: TextStyle(
                                fontSize: mq.height * .025,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Humidity",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: mq.height * .020),
                          )
                        ],
                      ),
                    )),

                //-----wind speed-----//
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 110,
                      width: mq.width * 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        color: Color.fromRGBO(255, 255, 255, 0.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/windspeed.svg",
                            height: mq.height * .04,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            weather.wind.speed.toString(),
                            style: TextStyle(
                                fontSize: mq.height * .025,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Wind Speed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: mq.height * .020),
                          )
                        ],
                      ),
                    )),

                //----Condition------------//
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 110,
                      width: mq.width * 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        color: Color.fromRGBO(255, 255, 255, 0.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/rain.svg",
                            height: mq.height * .04,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            weather.weather[0].description.trim(),
                            style: TextStyle(
                                fontSize: mq.height * .015,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Conditions",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: mq.height * .020),
                          )
                        ],
                      ),
                    )),
              ],
            ),

            //-----detail row2----------------------------//
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //-------sunrise----------------//
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 110,
                      width: mq.width * 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        color: Color.fromRGBO(255, 255, 255, 0.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/sunrise.svg",
                            height: mq.height * .04,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            APIs.formatTimestamp(weather.sys.sunrise),
                            style: TextStyle(
                                fontSize: mq.height * .025,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Sunrise",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: mq.height * .020),
                          )
                        ],
                      ),
                    )),

                //-------sunset-----------------//
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 110,
                      width: mq.width * 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        color: Color.fromRGBO(255, 255, 255, 0.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/sunset.svg",
                            height: mq.height * .04,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            APIs.formatTimestamp(weather.sys.sunset),
                            style: TextStyle(
                                fontSize: mq.height * .025,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Sunset",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: mq.height * .020),
                          )
                        ],
                      ),
                    )),

                //------sealevel-----------------//
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 110,
                      width: mq.width * 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        color: Color.fromRGBO(255, 255, 255, 0.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/sea.svg",
                            height: mq.height * .03,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            weather.main.seaLevel.toString(),
                            style: TextStyle(
                                fontSize: mq.height * .025,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "See",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: mq.height * .020),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
