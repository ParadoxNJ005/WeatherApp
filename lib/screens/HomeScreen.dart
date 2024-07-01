import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart'; // Ensure you have lottie package imported

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;

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
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/sunny.jpg"),
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
                      search(mq),
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
                            "Delhi",
                            style: TextStyle(
                                fontSize: mq.height * .03,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      weatherRow(mq),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Tuesday",
                        style: TextStyle(
                            fontSize: mq.height * .025,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "25 January 2024",
                        style: TextStyle(
                            fontSize: mq.height * .025,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      details(mq),
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
          ),
        ),
      ),
    );
  }

  Widget search(Size mq) {
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
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'City name ...',
                          ),
                          autofocus: true,
                          onChanged: (val) {},
                        ),
                      )
                    : Text(
                        'Delhi',
                        style: TextStyle(fontSize: mq.height * 0.03),
                      ),
              ),
              _isSearching
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              _isSearching = !_isSearching;
                            });
                          },
                          icon: Icon(Icons.cancel_outlined)),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget weatherRow(Size mq) {
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
                    'assets/sun.json',
                    width: mq.width * 0.31,
                    height: mq.height * 0.15,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text('Sunny',
                      style: TextStyle(
                          fontSize: mq.height * 0.04,
                          fontWeight: FontWeight.w400)),
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
                            text: "31",
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
                                text: "Min: 23.22",
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
                                text: "Max: 23.22",
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

  Widget details(Size mq) {
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
                            "70",
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
                            "3.33",
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
                            "Rain",
                            style: TextStyle(
                                fontSize: mq.height * .025,
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
                            "10054",
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
                            "10054",
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
                            "assets/svgs/see.svg",
                            height: mq.height * .03,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "100",
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
