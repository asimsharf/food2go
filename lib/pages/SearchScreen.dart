import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food2go/LoginClients/models/User.dart';
import 'package:food2go/model/Model_Merchant.dart';
import 'package:food2go/pages/CartPage.dart';
import 'package:food2go/pages/FavoritesPage.dart';
import 'package:food2go/pages/FilterSearch.dart';
import 'package:food2go/pages/MerchantDetails.dart';
import 'package:food2go/testApp/Search/contactslist.dart';
import 'package:food2go/testApp/SearchSecond.dart';
import 'package:food2go/tools/TextIcon.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../LoginClients/customviews/progress_dialog.dart';
import '../LoginClients/futures/app_futures.dart';
import '../LoginClients/models/base/EventObject.dart';
import '../LoginClients/pages/splash_page.dart';
import '../LoginClients/utils/app_shared_preferences.dart';
import '../LoginClients/utils/constants.dart';

class SearchScreen extends StatefulWidget {
  final Widget child;
  SearchScreen({Key key, this.child}) : super(key: key);
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final globalKey = new GlobalKey<ScaffoldState>();
  //__________________________________________________________________________________________________________//
//  User user;
  User user;

  TextEditingController oldPasswordController =
      new TextEditingController(text: "");

  TextEditingController newPasswordController =
      new TextEditingController(text: "");

//------------------------------------------------------------------------------

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (user == null) {
      await initUserProfile();
    }
  }

//------------------------------------------------------------------------------

  Future<void> initUserProfile() async {
    User up = await AppSharedPreferences.getUserProfile();
    setState(() {
      user = up;
    });
  }

//------------------------------------------------------------------------------

  static ProgressDialog progressDialog = ProgressDialog.getProgressDialog(
      ProgressDialogTitles.USER_CHANGE_PASSWORD);

//------------------------------------------------------------------------------
  //_________________________________________________________________________________________________________//
  TextEditingController TextSearcheditingController =
      new TextEditingController();

  String filter;
  bool loading = false;

  List<Model_Merchant> _browse_restaurant = <Model_Merchant>[];

  Future<List<Model_Merchant>> getBrowseRestaurant() async {
    String link = "http://mazzaya.net/restomax/mobileapp/api/BrowseRestaurant";

    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});

    setState(() {
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        var rest = data[0]['details']['data'] as List;
        _browse_restaurant = rest
            .map<Model_Merchant>((rest) => Model_Merchant.fromJson(rest))
            .toList();
        loading = false;
      }
    });

    return _browse_restaurant;
  }

  @override
  void initState() {
    super.initState();

    this.getBrowseRestaurant();

    TextSearcheditingController.addListener(() {
      setState(() {
        filter = TextSearcheditingController.text;
      });
    });
    setState(() {
      loading = true;
    });
  }

  @override
  void dispose() {
    TextSearcheditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: new AppBar(
        title: Text(
          'Food2GO',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: new Drawer(
          child: Container(
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/drawerbg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(((user == null) ? "Username" : user.name),
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                  )),
              accountEmail:
                  new Text(((user == null) ? "User Email" : user.email),
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      )),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(
                  Icons.person,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            new ListTile(
              leading: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(
                  Icons.home,
                  color: Colors.deepOrange,
                  size: 20.0,
                ),
              ),
              title: new Text("Home",
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)),
              onTap: () {},
            ),
            new ListTile(
              leading: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(
                  Icons.reorder,
                  color: Colors.deepOrange,
                  size: 20.0,
                ),
              ),
              title: new Text("My Order",
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //CategoryItemsPages
                    builder: (context) => CartPage(),
                  ),
                );
              },
            ),
            new ListTile(
              leading: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(
                  Icons.favorite,
                  color: Colors.deepOrange,
                  size: 20.0,
                ),
              ),
              title: new Text("Favorites",
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      fontWeight: FontWeight.bold,
                      package: 'google_fonts_arabic',
                      color: Colors.white,
                      fontSize: 20.0)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesPage(),
                  ),
                );
              },
            ),
            new ListTile(
                leading: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: new Icon(
                    Icons.local_offer,
                    color: Colors.deepOrange,
                    size: 20.0,
                  ),
                ),
                title: new Text("Offers",
                    style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0)),
                onTap: () {}),
            new ListTile(
              leading: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(
                  Icons.location_on,
                  color: Colors.deepOrange,
                  size: 20.0,
                ),
              ),
              title: new Text("Delivery Address",
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0)),
              onTap: () {},
            ),
            new Divider(
              color: Colors.white,
            ),
            new ListTile(
              leading: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(
                  Icons.verified_user,
                  color: Colors.deepOrange,
                  size: 20.0,
                ),
              ),
              title: new Text("Login",
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      fontWeight: FontWeight.bold,
                      package: 'google_fonts_arabic',
                      color: Colors.white,
                      fontSize: 20.0)),
              onTap: () {
                Navigator.popAndPushNamed(context, '/SplashPageLoginTow');
              },
            ),
            new ListTile(
              trailing: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(
                  Icons.verified_user,
                  color: Colors.deepOrange,
                  size: 20.0,
                ),
              ),
              title: new Text("Help",
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0)),
              onTap: () {},
            ),
            new ListTile(
              trailing: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(
                  Icons.info,
                  color: Colors.deepOrange,
                  size: 20.0,
                ),
              ),
              title: new Text("About Us",
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0)),
              onTap: () {},
            ),
            new ListTile(
              trailing: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(
                  Icons.exit_to_app,
                  color: Colors.deepOrange,
                  size: 20.0,
                ),
              ),
              title: new Text("SearchSecond",
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ),
                );
              },
            ),
            new ListTile(
              trailing: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(
                  Icons.exit_to_app,
                  color: Colors.deepOrange,
                  size: 20.0,
                ),
              ),
              title: new Text("TherdSecond",
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactsList(),
                  ),
                );
              },
            ),
            new ListTile(
              trailing: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(
                  Icons.exit_to_app,
                  color: Colors.deepOrange,
                  size: 20.0,
                ),
              ),
              title: new Text(Texts.LOGOUT,
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)),
              onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: globalKey.currentContext,
                    child: _logOutDialog());
              },
            ),
          ],
        ),
      )),
      body: new Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, right: 0.0, left: 0.0, bottom: 5.0),
              child: TextField(
//                onChanged: (text) {
//                  text = text.toLowerCase();
//                  setState(() {
//                    _browse_restaurant =
//                        _browse_restaurant.where((Model_Cards) {
//                      var _Model_Cards_full_name =
//                          Model_Cards.restaurant_name.toLowerCase();
//                      return _Model_Cards_full_name.contains(text);
//                    }).toList();
//                  });
//                },

                //onChanged: onSearchTextChanged,
//                onChanged: (value) {
//                  //filterSearchResults(value);
//                },
                controller: TextSearcheditingController,
                decoration: InputDecoration(
                    hintText: "Cuisine or restaurant name",
                    hintStyle: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                    ),
                    suffixIcon: InkWell(
                      splashColor: Colors.deepOrangeAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilterSearch(),
                          ),
                        );
                      },
                      child: Icon(
                        FontAwesomeIcons.slidersH,
                        color: Colors.deepOrange,
                      ),
                    ),
                    prefixIcon: GestureDetector(
                      child: Icon(
                        Icons.search,
                        color: Colors.deepOrange,
                      ),
                      onTap: () {},
                    ),
                    border: UnderlineInputBorder()),
              ),
            ),
            Expanded(
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 2),
                      ),
                      itemCount: _browse_restaurant.length,
                      itemBuilder: (BuildContext context, index) {
                        final ResturantObj = _browse_restaurant[index];
                        return filter == null || filter == ""
                            ? new GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => new MerchantDetails(
                                            merchant_id:
                                                ResturantObj.merchant_id,
                                            restaurant_name:
                                                ResturantObj.restaurant_name,
                                            distance: ResturantObj.distance,
                                            logo: ResturantObj.logo,
                                            lontitude: ResturantObj
                                                .map_coordinates.lontitude,
                                            latitude: ResturantObj
                                                .map_coordinates.latitude,
//                            ratings: ResturantObj.ratings.ratings,
                                            cuisine_name: ResturantObj.cuisine,
                                            merchant_bg:
                                                ResturantObj.merchant_bg,
                                            offers: ResturantObj.offers,
                                            is_open: ResturantObj.is_open,
                                            address: ResturantObj.address,
                                            delivery_fee:
                                                ResturantObj.delivery_fee,
                                            delivery_estimation: ResturantObj
                                                .delivery_estimation,
                                          ),
                                    ),
                                  );
                                },
                                child: new Card(
                                  child: new Column(
                                    children: [
                                      new Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                            image: new NetworkImage(
                                                ResturantObj.merchant_bg),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        child: new Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          verticalDirection:
                                              VerticalDirection.down,
                                          children: <Widget>[
                                            Container(
                                              width: 60,
                                              height: 60,
                                              margin: EdgeInsets.all(50.0),
                                              alignment: Alignment.center,
                                              decoration: new BoxDecoration(
                                                  // color: Colors.deepOrangeAccent,
                                                  color: Colors.white12,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    new BoxShadow(
                                                      color: Colors
                                                          .deepOrangeAccent,
                                                      blurRadius: 10.0,
                                                    ),
                                                  ]),
                                              child: new Center(
                                                child: new Text(
                                                  "${45}%",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          ArabicFonts.Cairo,
                                                      package:
                                                          'google_fonts_arabic',
                                                      fontSize: 20.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      new Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  7 +
                                              60,
                                          color: Colors.white.withOpacity(1.0),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      ResturantObj
                                                          .restaurant_name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            ArabicFonts.Cairo,
                                                        package:
                                                            'google_fonts_arabic',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      ResturantObj.cuisine,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .body2
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  Text(
                                                    ResturantObj.is_open,
                                                    style: new TextStyle(
                                                        fontFamily:
                                                            ArabicFonts.Cairo,
                                                        package:
                                                            'google_fonts_arabic',
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      ResturantObj.address,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  TextIcon(
                                                    text:
                                                        '${ResturantObj.service}',
                                                    icon: FontAwesomeIcons
                                                        .screwdriver,
                                                    isColumn: false,
                                                  ),
                                                  TextIcon(
                                                    text:
                                                        '${ResturantObj.distance}',
                                                    icon: FontAwesomeIcons
                                                        .locationArrow,
                                                    isColumn: false,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      ResturantObj.offers,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              ArabicFonts.Cairo,
                                                          fontSize: 10.0,
                                                          package:
                                                              'google_fonts_arabic',
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      'Delevery free ${ResturantObj.delivery_fee}',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              ArabicFonts.Cairo,
                                                          package:
                                                              'google_fonts_arabic',
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            : '${_browse_restaurant[index].restaurant_name}'
                                    .toLowerCase()
                                    .contains(filter.toLowerCase())
                                ? new GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (context) =>
                                              new MerchantDetails(
                                                merchant_id:
                                                    ResturantObj.merchant_id,
                                                restaurant_name: ResturantObj
                                                    .restaurant_name,
                                                distance: ResturantObj.distance,
                                                logo: ResturantObj.logo,
                                                lontitude: ResturantObj
                                                    .map_coordinates.lontitude,
                                                latitude: ResturantObj
                                                    .map_coordinates.latitude,
//                            ratings: ResturantObj
//                                .ratings.ratings,
                                                cuisine_name:
                                                    ResturantObj.cuisine,
                                                merchant_bg:
                                                    ResturantObj.merchant_bg,
                                                offers: ResturantObj.offers,
                                                is_open: ResturantObj.is_open,
                                                address: ResturantObj.address,
                                                delivery_fee:
                                                    ResturantObj.delivery_fee,
                                                delivery_estimation:
                                                    ResturantObj
                                                        .delivery_estimation,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: Column(
                                        children: [
                                          new Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            decoration: new BoxDecoration(
                                              image: new DecorationImage(
                                                image: new NetworkImage(
                                                    ResturantObj.merchant_bg),
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              verticalDirection:
                                                  VerticalDirection.down,
                                              children: <Widget>[
                                                new Container(
                                                  width: 100,
                                                  height: 100,
                                                  margin: EdgeInsets.all(50.0),
                                                  alignment: Alignment.center,
//                                                  decoration: new BoxDecoration(
//                                                    color:
//                                                        Colors.deepOrangeAccent,
//                                                    shape: BoxShape.circle,
//                                                  ),
                                                  decoration: new BoxDecoration(
                                                      color: Colors.black12,
                                                      boxShadow: [
                                                        new BoxShadow(
                                                          color: Colors.black26,
                                                          blurRadius: 1.0,
                                                        ),
                                                      ]),

                                                  child: new Center(
                                                    child: new Text(
                                                      "${45}%",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              ArabicFonts.Cairo,
                                                          package:
                                                              'google_fonts_arabic',
                                                          fontSize: 20.0,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          new Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      7 +
                                                  60,
                                              color:
                                                  Colors.white.withOpacity(1.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(
                                                          ResturantObj
                                                              .restaurant_name,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                ArabicFonts
                                                                    .Cairo,
                                                            package:
                                                                'google_fonts_arabic',
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
//                                                      Text(
//                                                        '${ResturantObj.ratings.ratings}',
//                                                        style: new TextStyle(
//                                                            fontFamily:
//                                                                ArabicFonts
//                                                                    .Cairo,
//                                                            package:
//                                                                'google_fonts_arabic',
//                                                            color:
//                                                                Colors.black),
//                                                      ),
                                                      SmoothStarRating(
                                                        rating: 5,
                                                        color: Colors.yellow,
                                                        size: 25,
                                                        starCount: 5,
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(
                                                          "cat1,cat2,cat3",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .body2
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      Text(
                                                        ResturantObj.is_open,
                                                        style: new TextStyle(
                                                            fontFamily:
                                                                ArabicFonts
                                                                    .Cairo,
                                                            package:
                                                                'google_fonts_arabic',
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(
                                                          ResturantObj.cuisine,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      TextIcon(
                                                        text:
                                                            '${ResturantObj.service}',
                                                        icon: FontAwesomeIcons
                                                            .screwdriver,
                                                        isColumn: false,
                                                      ),
                                                      TextIcon(
                                                        text:
                                                            '${ResturantObj.distance}',
                                                        icon: FontAwesomeIcons
                                                            .locationArrow,
                                                        isColumn: false,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(
                                                          ResturantObj.offers,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  ArabicFonts
                                                                      .Cairo,
                                                              fontSize: 10.0,
                                                              package:
                                                                  'google_fonts_arabic',
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(
                                                          ResturantObj.address,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  ArabicFonts
                                                                      .Cairo,
                                                              package:
                                                                  'google_fonts_arabic',
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  )
                                : new Container();
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: new MaterialButton(
                onPressed: () {},
                color: Colors.red,
                textColor: Colors.white,
                elevation: 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("DELEVERY",
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      )),
                ),
              ),
            ),
            Expanded(
              child: new MaterialButton(
                onPressed: () {},
                color: Colors.red,
                textColor: Colors.white,
                elevation: 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("PICK-UP",
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //_________________________________________________________________________________________//
  //_________________________________________________________________________________________//

//------------------------------------------------------------------------------

  //Login Class for the application
  void _logoutFromTheApp() {
    AppSharedPreferences.clear();
    setState(() {
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => new SplashPageLoginTow()),
      );
    });
  }

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------

  Widget _logOutDialog() {
    return new AlertDialog(
      title: new Text(
        "Logout",
        style: new TextStyle(color: Colors.deepOrange, fontSize: 20.0),
      ),
      content: new Text(
        "Are you suer ? Want to LogOut!",
        style: new TextStyle(color: Colors.grey, fontSize: 20.0),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text("ok",
              style: new TextStyle(color: Colors.deepOrange, fontSize: 20.0)),
          onPressed: () {
            AppSharedPreferences.clear();
            Navigator.popAndPushNamed(context, '/SearchScreen');
          },
        ),
        new FlatButton(
          child: new Text("Cansel",
              style: new TextStyle(color: Colors.deepOrange, fontSize: 20.0)),
          onPressed: () {
            Navigator.of(globalKey.currentContext).pop();
          },
        ),
      ],
    );
  }

//------------------------------------------------------------------------------

  Widget _changePasswordDialog() {
    return new AlertDialog(
      title: new Text(
        "change Password",
        style: new TextStyle(color: Colors.deepOrange, fontSize: 20.0),
      ),
      content: new Container(
        child: new Form(
            child: new Theme(
                data: new ThemeData(primarySwatch: Colors.deepOrange),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Container(
                        child: new TextFormField(
                          controller: oldPasswordController,
                          decoration: InputDecoration(
                              suffixIcon: new Icon(
                                Icons.vpn_key,
                                color: Colors.deepOrange,
                              ),
                              labelText: Texts.OLD_PASSWORD,
                              labelStyle: TextStyle(fontSize: 18.0)),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        margin: EdgeInsets.only(bottom: 10.0)),
                    new Container(
                        child: new TextFormField(
                          controller: newPasswordController,
                          decoration: InputDecoration(
                              suffixIcon: new Icon(
                                Icons.vpn_key,
                                color: Colors.deepOrange,
                              ),
                              labelText: Texts.NEW_PASSWORD,
                              labelStyle: TextStyle(fontSize: 18.0)),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        margin: EdgeInsets.only(bottom: 10.0)),
                  ],
                ))),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text("okay",
              style: new TextStyle(color: Colors.deepOrange, fontSize: 20.0)),
          onPressed: () {
            if (oldPasswordController.text == "") {
              globalKey.currentState.showSnackBar(new SnackBar(
                content: new Text(SnackBarText.ENTER_OLD_PASS),
              ));
              return;
            }

            if (newPasswordController.text == "") {
              globalKey.currentState.showSnackBar(new SnackBar(
                content: new Text(SnackBarText.ENTER_NEW_PASS),
              ));
              return;
            }

            FocusScope.of(globalKey.currentContext)
                .requestFocus(new FocusNode());
            Navigator.of(globalKey.currentContext).pop();
            progressDialog.showProgress();
            _changePassword(user.email, oldPasswordController.text,
                newPasswordController.text);
          },
        ),
        new FlatButton(
          child: new Text("Cansel",
              style: new TextStyle(color: Colors.deepOrange, fontSize: 20.0)),
          onPressed: () {
            Navigator.of(globalKey.currentContext).pop();
          },
        ),
      ],
    );
  }

//------------------------------------------------------------------------------
  void _changePassword(
      String emailID, String oldPassword, String newPassword) async {
    EventObject eventObject =
        await changePassword(emailID, oldPassword, newPassword);
    switch (eventObject.id) {
      case EventConstants.CHANGE_PASSWORD_SUCCESSFUL:
        {
          setState(() {
            oldPasswordController.text = "";
            newPasswordController.text = "";
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.CHANGE_PASSWORD_SUCCESSFUL),
            ));
            progressDialog.hideProgress();
          });
        }
        break;
      case EventConstants.CHANGE_PASSWORD_UN_SUCCESSFUL:
        {
          setState(() {
            oldPasswordController.text = "";
            newPasswordController.text = "";
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.CHANGE_PASSWORD_UN_SUCCESSFUL),
            ));
            progressDialog.hideProgress();
          });
        }
        break;
      case EventConstants.INVALID_OLD_PASSWORD:
        {
          setState(() {
            oldPasswordController.text = "";
            newPasswordController.text = "";
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.INVALID_OLD_PASSWORD),
            ));
            progressDialog.hideProgress();
          });
        }
        break;
      case EventConstants.NO_INTERNET_CONNECTION:
        {
          setState(() {
            oldPasswordController.text = "";
            newPasswordController.text = "";
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.NO_INTERNET_CONNECTION),
            ));
            progressDialog.hideProgress();
          });
        }
        break;
    }
  }
  //_________________________________________________________________________________________//
  //_________________________________________________________________________________________//
}
