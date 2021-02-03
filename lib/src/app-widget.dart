import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meus_carros/src/login/login-widget.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meus carros",
      home: AnimatedSplashScreen(
        splash: Icon(
          FontAwesomeIcons.carAlt,
          color: Colors.black,
          size: 170,
        ),
        splashTransition: SplashTransition.scaleTransition,
        duration: 200,
        nextScreen: LoginWidget(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
