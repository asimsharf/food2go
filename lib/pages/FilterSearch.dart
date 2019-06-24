import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class FilterSearch extends StatefulWidget {
  @override
  _FilterSearchState createState() => _FilterSearchState();
}

class _FilterSearchState extends State<FilterSearch> {
  String dropdownValue1 = '';
  String dropdownValue2 = '';
  String dropdownValue3 = '';
  String dropdownValue4 = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Filtter Search by",
            style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Resturant name",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF37505D),
                        fontSize: 18.0)),
                SizedBox(
                  width: 20.0,
                ),
                DropdownButton<String>(
                  value: dropdownValue1,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue1 = newValue;
                    });
                  },
                  items: <String>['', 'amirican', 'sudan', 'somting']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF37505D),
                              fontSize: 18.0)),
                    );
                  }).toList(),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Discound",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF37505D),
                        fontSize: 18.0)),
                SizedBox(
                  width: 20.0,
                ),
                DropdownButton<String>(
                  value: dropdownValue2,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue2 = newValue;
                    });
                  },
                  items: <String>['', '10%', '30%', '50%']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF37505D),
                              fontSize: 18.0)),
                    );
                  }).toList(),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Ratting",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF37505D),
                        fontSize: 18.0)),
                SizedBox(
                  width: 20.0,
                ),
                DropdownButton<String>(
                  value: dropdownValue3,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue3 = newValue;
                    });
                  },
                  items: <String>['', '4', '3.4', '5']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF37505D),
                              fontSize: 18.0)),
                    );
                  }).toList(),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Meal type",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF37505D),
                        fontSize: 18.0)),
                SizedBox(
                  width: 20.0,
                ),
                DropdownButton<String>(
                  value: dropdownValue4,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue4 = newValue;
                    });
                  },
                  items: <String>['', 'salad', 'pizza', 'sout']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF37505D),
                              fontSize: 18.0)),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            new MaterialButton(
              height: 40.0,
              minWidth: 150.0,
              color: Colors.deepOrange,
              splashColor: Colors.deepOrangeAccent,
              textColor: Colors.white,
              child: new Text("Seatch",
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              onPressed: () {},
            ),
          ],
        ),
      )),
    );
  }
}
