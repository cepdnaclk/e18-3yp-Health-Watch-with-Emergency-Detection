import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:medicare1/location_page.dart';
import 'package:medicare1/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicare',
      theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 15, 202, 155),
              primary: Color.fromARGB(255, 15, 202, 155), //<-- SEE HERE
            ),
        primaryColor: Color.fromARGB(255, 15, 202, 155),
      ),
      home: AnimatedSplashScreen(splash: Image.asset('images/title.png'),duration: 3000,splashIconSize: 200,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
      nextScreen: LoginPage("")),
      //nextScreen: LocationPage()),
    );
  }
}