import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/bg_v.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.play();
    _controller.setLooping(true);
    _controller.setVolume(0.0);
    Timer.periodic(Duration(seconds: 6), (Timer t) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: _controller.value.initialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          new Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Center(
                    child: Text(
                      "YOUR FAVORITE FOOD DELIVERED IN 45 MIN!",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  new RaisedButton(
                    splashColor: Colors.deepOrangeAccent[100],
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/SearchScreen');
                      //Navigator.pushNamedAndRemoveUntil(context, '/SearchScreen', predicate)
                      //Navigator.pushReplacementNamed(context, '/SearchScreen');
                    },
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('NERBAY',
                          style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            fontWeight: FontWeight.bold,
                            package: 'google_fonts_arabic',
                          )),
                    ),
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 20.0),
                  new Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          height: 20.0,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Text(
                        'OR',
                        style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 24.0),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          height: 20.0,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  new TextFormField(
                    autofocus: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 20.0),
                      hintStyle: TextStyle(
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                          color: Colors.black26),
                      filled: true,
                      fillColor: Colors.white70,
                      hintText: 'Enter Adress',
                    ),
                  ),
                  const SizedBox(height: 100.0),
                  new Center(
                    child: Text(
                      "Order food from over 8000 of Sweeden's best restaurants!",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
