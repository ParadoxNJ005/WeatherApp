import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/main.dart';
import 'package:weather/screens/HomeScreen.dart';
import 'package:weather/service/apis.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //------------------controllers for the city text field-----------------//

  TextEditingController _cityController = TextEditingController();
  var _Formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  //----------------------------To Check if the Searched City exists------------------------//
  // Future<bool> _checkcity(String city) async {
  //   try {
  //     final response = await APIs.fetch(city);
  //     return response != null;
  //   } catch (e) {
  //     log('Error checking city: $e');
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //----------------------------------Media query---------------------------//
    final mq = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body:

            //--------------------------------------Background image-----------------------------//
            Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/w_back.jpg"),
              fit: BoxFit.cover,
            ),
          ),

          //----------------------------------Stack----------------------------------------------//
          child: Stack(
            alignment: Alignment.center,
            children: [
              //------------------------------Text(Quote)----------------------------------------//
              Positioned(
                top: mq.height * 0.55,
                child: Text(
                  '    Weather Matters,\nWe\'ve Got the Details',
                  style: TextStyle(
                    fontSize: mq.height * .04,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //------------------------------cloud svg-----------------------------------------//
              Positioned(
                top: mq.height * 0.2,
                child: SvgPicture.asset(
                  'assets/clouds.svg',
                  width: mq.height * 0.35,
                  height: mq.width * 0.35,
                ),
              ),
              //------------------------------sun svg-------------------------------------------//
              Positioned(
                top: mq.height * 0.05,
                child: Padding(
                  padding: EdgeInsets.only(right: 180),
                  child: SvgPicture.asset(
                    'assets/sun.svg',
                    width: mq.height * 0.2,
                    height: mq.width * .2,
                  ),
                ),
              ),
              //-------------------------------text(my name)------------------------------------//
              Positioned(
                top: mq.height * 0.95,
                child: Text(
                  'Designed by Naitik Jain',
                  style: TextStyle(
                    fontSize: mq.height * .02,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              //-------------------------------------Text Form Field(Enter City)-----------------------//
              Positioned(
                top: mq.height * 0.7,
                child: Container(
                  width: mq.width * 0.8,
                  height: mq.height * 0.07,
                  child: Form(
                    key: _Formkey,
                    child: TextFormField(
                      controller: _cityController,
                      key: ValueKey('City'),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 220, 217, 217),
                        hintText: "Enter City Name..",
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black),
                        errorStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter city name';
                        }
                        // Future<bool> cityExists = _checkcity(value);
                        // if (cityExists == false) {
                        //   return 'City not found';
                        // }
                        return null;
                      },
                    ),
                  ),
                ),
              ),

              //----------------------------------------Submit Button------------------------------//
              Positioned(
                top: mq.height * 0.78,
                child: Container(
                  width: mq.width * .8,
                  height: mq.height * 0.05,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_Formkey.currentState!.validate()) {
                        _Formkey.currentState!.save();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(
                              initcity: _cityController.text.trim(),
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Search",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(144, 186, 238, 1)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
