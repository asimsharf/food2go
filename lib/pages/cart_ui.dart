import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-model/items_model.dart';
import 'cart_list.dart';

class CartPage extends StatelessWidget {
  String item_name;

  CartPage({this.item_name});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          actions: <Widget>[
            Center(
              child: Container(
                  padding: EdgeInsets.only(right: 15),
                  child:
                      Text(model.getCartList.length.toString() + ' item/\s')),
            )
          ],
        ),
        body: Cart(),
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
                    child: new Text(
                        "Total Amount ${model.getCartPrice.toString()}",
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
                    child: new Text("CHECK-OUT",
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
    });
  }
}
