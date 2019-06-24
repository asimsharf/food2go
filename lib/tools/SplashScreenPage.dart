import 'package:flutter/material.dart';
import 'package:food2go/pages/HomePage.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new AfterSplash(),
        image: new Image.asset('assets/images/ic_launcher.png'),
        gradientBackground: new LinearGradient(
            colors: [Colors.deepOrange, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        backgroundColor: Colors.amber,
        title: new Text(
          "YOUR FAVORITE FOOD DELIVERED IN 45 MIN!",
          style: new TextStyle(
              fontFamily: 'Bree Serif',
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: Colors.white),
        ),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 120.0,
        onClick: () => print("Food2to"),
        loaderColor: Colors.white,
        loadingText: new Text(
          'loading...',
          style: new TextStyle(
              fontFamily: 'Bree Serif',
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: Colors.white),
        ));
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
