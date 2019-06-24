import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Ratting extends StatefulWidget {
  @override
  _RattingState createState() => _RattingState();
}

class _RattingState extends State<Ratting> {
  var rating = 1.2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rating bar demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
            child: SmoothStarRating(
          rating: rating,
          size: 45,
          starCount: 5,
          onRatingChanged: (value) {
            setState(() {
              rating = value;
            });
          },
        )),
      ),
    );
  }
}
//
//SmoothStarRating(
//allowHalfRating: false,
//onRatingChanged: (v) {
//rating = v;
//setState(() {});
//},
//starCount: 5,
//rating: rating,
//size: 40.0,
//color: Colors.green,
//borderColor: Colors.green,
//)
