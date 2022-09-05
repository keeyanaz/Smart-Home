import 'package:flutter/material.dart';
import 'package:smart_home/LandingScreen/landing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:smart_home/SensorScreen/sensor_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins'),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SensorScreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LandingScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("..."),
      ),
    );
  }
}