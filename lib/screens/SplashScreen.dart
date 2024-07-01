import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/main.dart';
import 'package:weather/screens/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.white));

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/w_back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: mq.height * 0.6,
              child: Text(
                '    Weather Matters,\nWe\'ve Got the Details',
                style: TextStyle(
                  fontSize: mq.height * .04,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: mq.height * 0.4,
              child: SvgPicture.asset(
                'assets/clouds.svg',
                width: mq.height * 0.35,
                height: mq.width * 0.35,
              ),
            ),
            Positioned(
              top: mq.height * 0.35,
              child: Padding(
                padding: EdgeInsets.only(right: 180),
                child: SvgPicture.asset(
                  'assets/sun.svg',
                  width: mq.height * 0.2,
                  height: mq.width * .2,
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
