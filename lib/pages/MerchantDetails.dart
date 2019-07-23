import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food2go/model/Model_Category.dart';
import 'package:food2go/pages/DishesPage.dart';
import 'package:food2go/tools/TextIcon.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MerchantDetails extends StatefulWidget {
  String merchant_id;
  String restaurant_name;
  String distance;
  String logo;
  String lontitude;
  String latitude;
  String offers;
  int ratings;
  String cuisine_name;
  String is_open;
  String address;
  String merchant_bg;
  String delivery_fee;
  String delivery_estimation;

  MerchantDetails({
    this.merchant_id,
    this.restaurant_name,
    this.distance,
    this.logo,
    this.lontitude,
    this.latitude,
    this.offers,
    this.ratings,
    this.cuisine_name,
    this.is_open,
    this.address,
    this.merchant_bg,
    this.delivery_fee,
    this.delivery_estimation,
  });
  @override
  State createState() => _CreateCenter();
}

class _CreateCenter extends State<MerchantDetails> {
  bool loading = false;
  List<Model_Category> _category = <Model_Category>[];

  Future<List<Model_Category>> get_all_category() async {
    String link =
        "http://www.mazzaya.net/restomax/api/get_all_category.php?merchant_id=${widget.merchant_id}";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    setState(() {
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        var rest = data as List;
        _category = rest
            .map<Model_Category>((rest) => Model_Category.fromJson(rest))
            .toList();
        loading = false;
      }
    });
    return _category;
  }

  @override
  void initState() {
    super.initState();
    this.get_all_category();
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.passthrough, children: <Widget>[
        SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new NetworkImage(
                          widget.merchant_bg,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget.restaurant_name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SmoothStarRating(
                                rating: 4,
                                size: 25,
                                color: Colors.yellow,
                                borderColor: Colors.white70,
                                allowHalfRating: true,
                                starCount: 5,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget.cuisine_name,
                                  style: new TextStyle(
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                      color: Colors.black),
                                ),
                              ),
                              Text(
                                widget.is_open,
                                style: new TextStyle(
                                    color: Colors.blue,
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              Icon(
                                Icons.lock_open,
                                color: Colors.green,
                                size: 14.0,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Delevery free ${widget.delivery_fee}',
                                  style: TextStyle(
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                      color: Colors.black),
                                ),
                              ),
                              TextIcon(
                                text: '${widget.distance}',
                                icon: FontAwesomeIcons.locationArrow,
                                isColumn: false,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  '${widget.offers}',
                                  style: TextStyle(
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget.address,
                                  style: TextStyle(
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                      color: Colors.black),
                                ),
                              ),
                              Text(
                                '${widget.delivery_estimation}',
                                style: new TextStyle(
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              Icon(
                                Icons.lock_open,
                                color: Colors.green,
                                size: 14.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: loading
                        ? Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height / 2),
                            ),
                            itemCount: _category.length,
                            itemBuilder: (BuildContext context, index) {
                              final CategoryObj = _category[index];

                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              DishesPage(
                                                cat_id: CategoryObj.cat_id,
                                                merchant_id: widget.merchant_id,
                                                merchant_bg: widget.merchant_bg,
                                              )),
                                    );
                                  },
                                  child: Card(
                                      elevation: 3.0,
                                      margin: new EdgeInsets.all(2.0),
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                            colorFilter:
                                                ColorFilter.srgbToLinearGamma(),
                                            image: new NetworkImage(
                                              'http://mazzaya.net/restomax/upload/${CategoryObj.photo}',
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Container(
                                          decoration: new BoxDecoration(
                                              color: Colors.black12,
                                              boxShadow: [
                                                new BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 1.0,
                                                ),
                                              ]),
                                          child: new Center(
                                            child: new ListTile(
                                              title: new Center(
                                                child: new Text(
                                                  CategoryObj.category_name,
                                                  style: new TextStyle(
                                                    fontFamily:
                                                        ArabicFonts.Cairo,
                                                    package:
                                                        'google_fonts_arabic',
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              subtitle: Center(
                                                child: new Text(
                                                  CategoryObj
                                                      .category_description,
                                                  style: new TextStyle(
                                                    fontFamily:
                                                        ArabicFonts.Cairo,
                                                    package:
                                                        'google_fonts_arabic',
                                                    fontSize: 14.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )));
                            },
                          ),
                  ),
                ],
              ),
              // Profile image
              Positioned(
                right: 0.0,
                top: 100.0, // (background container size) - (circle height / 2)
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      //borderRadius: new BorderRadius.circular(1.0),
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                        bottomLeft: const Radius.circular(40.0),
                      ),
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/45.png"),
                        fit: BoxFit.cover,
                      ),
                      color: Color(0xFFFFF6E8)),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
