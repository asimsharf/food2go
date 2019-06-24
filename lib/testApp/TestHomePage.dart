import "package:flutter/material.dart";
import 'package:google_fonts_arabic/fonts.dart';

class TestHomePage extends StatefulWidget {
  @override
  _TestHomePageState createState() => new _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("TestHomePage"),
      ),
      body: new ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  colorFilter: ColorFilter.srgbToLinearGamma(),
                  image: new AssetImage(
                    'assets/images/food.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: new Container(
                height: 180.0,
                child: Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Text(
                          "Resturan Name",
                          style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Hader of tahe ",
                          style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Resturan Name",
                          style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
