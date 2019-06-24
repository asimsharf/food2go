import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
            )),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
