import 'package:flutter/material.dart';
import 'package:food2go/model/Model_Dishes.dart';
import 'package:food2go/pages/FavoritesPage.dart';
import 'package:food2go/scoped-model/items_model.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:scoped_model/scoped_model.dart';

import 'CartPage.dart';

class DishesDetail extends StatefulWidget {
  // ProductsModel model;
  String item_id;
  int cat_id;
  String merchant_id;
  String photo;
  String item_name;
  String item_description;
  final List<Prices> prices;
  String discount;
  String spicydish;
  String dish;
  int single_item;
  String single_details;
  String not_available;
  String merchant_bg;

  DishesDetail(
      {this.item_id,
      this.cat_id,
      this.merchant_id,
      this.photo,
      this.item_name,
      this.item_description,
      this.prices,
      this.single_details,
      this.discount,
      this.dish,
      this.not_available,
      this.single_item,
      this.spicydish,
      this.merchant_bg});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<DishesDetail> {
  // final ProductsModel productsmodel =ProductsModel();

  //=============================================================
  int priceP = 0;
  int qty = 1;

  void add() {
    setState(() {
      qty++;
    });
  }

  void minus() {
    setState(() {
      if (qty != 1) qty--;
    });
  }

//=============================================================

  List<String> _price;

  // List<>
  List<String> reportList = [
    "tomato",
    "betato",
    "salad",
    "fruite",
    "tom",
    "fresh fruite",
    "tum",
  ];

  List<String> selectedReportList = List();
  List<Prices> sizeandprice = [];

  List<String> getprice(List<Prices> pric) {
    for (var price_size in pric) {
      _price.add(price_size.size + ' |  \$' + price_size.price);
    }
    return _price;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool _isSelected = false;
    return new ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Dishes Detail",
            style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FavoritesPage()));
                }),
          ],
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: new Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            new Container(
              height: 300.0,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: NetworkImage('${widget.photo}'), fit: BoxFit.fill),
                borderRadius: new BorderRadius.only(
                  bottomRight: new Radius.circular(120.0),
                  bottomLeft: new Radius.circular(120.0),
                ),
              ),
            ),
            new Container(
              height: 300.0,
              decoration: new BoxDecoration(
                  color: Colors.grey.withAlpha(50),
                  borderRadius: new BorderRadius.only(
                    bottomRight: new Radius.circular(120.0),
                    bottomLeft: new Radius.circular(120.0),
                  )),
            ),
            new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new SizedBox(
                    height: 200.0,
                  ),

                  //==========================Item name===================================
                  new Card(
                    child: new Container(
                      width: screenSize.width,
                      margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            '${widget.item_name}',
                            style: new TextStyle(
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          new Text(
                            "${widget.item_description}",
                            style: new TextStyle(
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Icon(
                                    Icons.timer,
                                    color: Colors.black,
                                    size: 20.0,
                                  ),
                                  new SizedBox(
                                    width: 5.0,
                                  ),
                                  new Text(
                                    //"${widget.itemRating}",
                                    '${45}m  Delivery Time ',
                                    style: new TextStyle(
                                        fontFamily: ArabicFonts.Cairo,
                                        package: 'google_fonts_arabic',
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              new Text(
                                'Discount : %${widget.discount}',
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                    color: Colors.red[500],
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          new SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //=============================Description================================
                  new Card(
                    child: new Container(
                      width: screenSize.width,
                      margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new SizedBox(
                            height: 10.0,
                          ),
                          new Text(
                            "Description",
                            style: new TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          new SizedBox(
                            height: 10.0,
                          ),
                          new Text(
                            "${widget.item_description}",
                            style: new TextStyle(
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700),
                          ),
                          new SizedBox(
                            height: 10.0,
                          )
                        ],
                      ),
                    ),
                  ),
                  //============================Additions=================================
                  new Card(
                    child: new Container(
                      width: screenSize.width,
                      margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new SizedBox(
                            height: 10.0,
                          ),
                          new SizedBox(
                            height: 10.0,
                          ),
                          new Text(
                            "Addition",
                            style: new TextStyle(
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700),
                          ),
                          new SizedBox(
                            height: 10.0,
                          ),
                          new SizedBox(
                              height: 50.0,
                              child: AdditionsSelect(
                                reportList,
                                onSelectionChanged: (selectedList) {
                                  setState(() {
                                    selectedReportList = selectedList;
                                  });
                                },
                              )),
                          new SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //=========================Qty====================================
                  new Card(
                    child: new Container(
                      width: screenSize.width,
                      margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            "Quantity ",
                            style: new TextStyle(
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700),
                          ),
                          new SizedBox(
                            height: 50.0,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new FloatingActionButton(
                                  elevation: 1.0,
                                  heroTag: "addbtn",
                                  onPressed: add,
                                  child: new Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  backgroundColor: Colors.deepOrange,
                                ),
                                new Text('$qty',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                    )),
                                new FloatingActionButton(
                                  elevation: 1.0,
                                  heroTag: "minusbtn",
                                  onPressed: minus,
                                  child: new Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  backgroundColor: Colors.deepOrange,
                                ),
                              ],
                            ),
                          ),
                          new SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //==========================Size and price===================================
                  new Card(
                    child: new Container(
                      width: screenSize.width,
                      margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new SizedBox(
                            height: 10.0,
                          ),
                          new SizedBox(
                            height: 10.0,
                          ),
                          new Text(
                            "Size & price",
                            style: new TextStyle(
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700),
                          ),
                          new SizedBox(
                            height: 10.0,
                          ),
                          new SizedBox(
                            height: 50.0,
                            child: new ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.prices.length, //5,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: new ChoiceChip(
                                      label: Text(
                                        "${widget.prices[index].size} |  \$${widget.prices[index].price}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      selected: _isSelected,
                                      onSelected: (selected) {
                                        setState(() {
                                          priceP = int.parse(
                                              widget.prices[index].price);
                                          _isSelected = selected;
                                        });
                                      },
                                      backgroundColor: Colors.black38,
                                      selectedColor: Colors.red,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //===========================message==================================
                  new Card(
                    child: new Container(
                      width: screenSize.width,
                      margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new SizedBox(
                            height: 10.0,
                          ),
                          new Text(
                            "Message",
                            style: new TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          new SizedBox(
                            height: 10.0,
                          ),
                          new TextField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                          ),
                          new SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //=============================================================
                ],
              ),
            )
          ],
        ),
        floatingActionButton: new Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            new FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              heroTag: "btn1",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CartPage()),
                );
              },
              child: new Icon(Icons.shopping_cart),
            ),
            new CircleAvatar(
              radius: 10.0,
              backgroundColor: Colors.deepOrange,
              child: new Text(
                model.getCartList.length
                    .toString(), //to Show how many items in the cart
                style: new TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: Colors.white,
                    fontSize: 12.0),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: new BottomAppBar(
          color: Theme.of(context).primaryColor,
          elevation: 0.0,
          shape: CircularNotchedRectangle(),
          notchMargin: 5.0,
          child: new Container(
            height: 50.0,
            decoration:
                new BoxDecoration(color: Theme.of(context).primaryColor),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: _TotalItemPrice(priceP, qty),
                  ),
                ),
                GestureDetector(
                  onTap: () => model.addToCart(widget.item_id, qty, priceP,
                      widget.photo, widget.item_name),
                  child: new Container(
                    width: (screenSize.width - 20) / 2,
                    child: new Text(
                      "ADD TO CART",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _TotalItemPrice(int priceP, int qty) {
    return new ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      Widget TotalItemPrice;
      if (priceP > 0) {
        TotalItemPrice = Text(
          "Total Amount ${model.getItemPrice(priceP, qty).toString()}",
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: Colors.white,
              fontWeight: FontWeight.w700),
        );
      } else {
        TotalItemPrice = Text(
          "Total Amount 0.0",
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: Colors.white,
              fontWeight: FontWeight.w700),
        );
      }
      return TotalItemPrice;
    });
  }
}

class AdditionsSelect extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  AdditionsSelect(this.reportList, {this.onSelectionChanged});

  @override
  _AdditionsSelectState createState() => _AdditionsSelectState();
}

class _AdditionsSelectState extends State<AdditionsSelect> {
  // String selectedChoice = "";
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
