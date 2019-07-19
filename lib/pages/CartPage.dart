import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food2go/model/Item.dart';
import 'package:food2go/model/Response.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-model/items_model.dart';

class CartPage extends StatelessWidget {
  final globalKey = new GlobalKey<ScaffoldState>();
  String item_name;
  final Item item;
  String merchant_id;
  CartPage({this.item_name, this.item, this.merchant_id});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return Scaffold(
        key: globalKey,
        appBar: new AppBar(
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
        body: _buildProductList(model.getCartList, model),
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
                  onPressed: () =>
                      _onValidBtnPressed(context, model, globalKey),
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

  Widget cartCard(Item item) {
    return new Dismissible(
      key: Key('value'),
      onDismissed: (DismissDirection direction) {},
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.green,
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              '${item.item_name}',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(item.photo),
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                margin: EdgeInsets.only(left: 16, top: 5, right: 5, bottom: 5),
                height: 100,
                width: 100,
              ),
              Flexible(
                child: Container(
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'Price: ${item.price.toString()}',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Lato',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'QTY: ${item.qty.toString()}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Roboto',
                            color: Color(0xFF212121),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _buildProductModel_Dishess(
      BuildContext context, int position, Item item, ProductsModel model) {
    return cartCard(item);
  }

  Widget _buildProductList(List<Item> items, ProductsModel model) {
    Widget productCard;
    if (items.length > 0) {
      productCard = SafeArea(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              _buildProductModel_Dishess(
                context,
                index,
                items[index],
                model,
              ),
          itemCount: items.length,
        ),
      );
    } else {
      productCard = Center(child: Text('YOUR CART IS EMPTY  :( '));
    }
    return productCard;
  }

  Widget cartList() {
    return new ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {},
    );
  }
}

_onValidBtnPressed(BuildContext context, ProductsModel model,
    GlobalKey<ScaffoldState> globalKey) {
  var res;
  List<Responsse> jsn;
  Alert(
      context: context,
      title: "ORDER DETAILS",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Text(
                'Total Price: ${model.getCartPrice.toString()}',
                style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: Colors.grey,
                    fontSize: 15),
              )
            ],
          ),
          Row(
            children: <Widget>[
              new Text(
                'Total Item: ${model.getCartList.length.toString()}',
                style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: Colors.grey,
                    fontSize: 15),
              )
            ],
          ),
          Row(
            children: <Widget>[
              new Text(
                'Pyment method: Cash on delevery',
                style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: Colors.grey,
                    fontSize: 15),
              )
            ],
          ),
        ],
      ),
      buttons: [
        DialogButton(
          //client_token
          //transaction_type
          //payment_list
          onPressed: () => {
                res = model.placeOrder(
                    "1",
                    "pickup",
                    "0dvgnimmnqh1wc52cee5764deecab20289679cba502dcf0",
                    "cod",
                    json.encode(model.getCartList).toString()),
                jsn.add(Responsse.fromJson(json.decode(json.encode(res)))),
              }, //_placeOrderButtonAction( context, model,globalKey),
          color: Colors.deepOrange,
          child: Text(
            "okay",
            style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                color: Colors.white,
                fontSize: 20),
          ),
        ),
        DialogButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.deepOrange,
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  color: Colors.white,
                  fontSize: 20),
            ))
      ]).show();
}

_onChackBtnPressedOkay(BuildContext context, ProductsModel model) {
  Alert(
    context: context,
    title: "Order Complet",
    type: AlertType.success,
    desc: "your order has been completed successfully",
    buttons: [
      DialogButton(
        child: Text(
          "okay",
          style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: Colors.white,
              fontSize: 20),
        ), //CartPage 274
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        color: Colors.deepOrange,
      )
    ],
  ).show();
}

_placeOrderButtonAction(BuildContext context, ProductsModel model,
    GlobalKey<ScaffoldState> globalKey) {
  var mapper = "";
  Responsse res;
  mapper = model.placeOrder(
      '1' /*merchant_id*/,
      "pickup" /*transaction_type*/,
      "0dvgnimmnqh1wc52cee5764deecab20289679cba502dcf0" /*client_token*/,
      "cod" /*payment_list*/,
      json.encode(model.getCartList).toString());
  print("##################");
  print(" mapper :" + mapper);
  res = Responsse.fromJson(json.decode(json.encode(mapper)));
  print("##################res: ${res}");

  // if(mapper == ""){
  //   print(' ################# from inside if code is equal :'+json.decode(mapper).code.toString());

  // }else{

  //   if (json.decode(mapper).code == 1) {
  //   globalKey.currentState.showSnackBar(new SnackBar(
  //     content: new Text(
  //       "congratulations enjoy !",
  //       style: TextStyle(color: Colors.white),
  //     ),
  //   ));
  //   return;
  // }else if (json.decode(mapper).code == 2) {
  //   globalKey.currentState.showSnackBar(new SnackBar(
  //     content: new Text(
  //       "Sorry something wroung !",
  //       style: TextStyle(color: Colors.white),
  //     ),
  //   ));
  //   return;
  // }else if (json.decode(mapper).code == 3) {
  //   globalKey.currentState.showSnackBar(new SnackBar(
  //     content: new Text(
  //       "don't know Why !",
  //       style: TextStyle(color: Colors.white),
  //     ),
  //   ));
  //   return;
  // }else {
  //   globalKey.currentState.showSnackBar(new SnackBar(
  //     content: new Text(
  //       "No Way ):- !",
  //       style: TextStyle(color: Colors.white),
  //     ),
  //   ));
  //   return;
  // }
  //   print(' ################# from inside else code is equal :'+ json.decode(mapper).code.toString());
  // }
  print(model.placeOrder(
      '1' /*merchant_id*/,
      "cod" /*transaction_type*/,
      "0dvgnimmnqh1wc52cee5764deecab20289679cba502dcf0" /*client_token*/,
      "cod" /*payment_list*/,
      json.encode(model.getCartList).toString()));

  _onChackBtnPressedOkay(context) {
    Alert(
      context: context,
      title: "Order Complet",
      type: AlertType.success,
      desc: "your order has been completed successfully",
      buttons: [
        DialogButton(
          child: Text(
            "okay",
            style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                color: Colors.white,
                fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          color: Colors.deepOrange,
        )
      ],
    ).show();
  }
}

// _onOrderBtnPressed(BuildContext context, ProductsModel model) {
//   Widget orderwidget;
//     // print(model.placeOrder(1/*merchant_id*/,"cod"/*transaction_type*/,"0dvgnimmnqh1wc52cee5764deecab20289679cba502dcf0"/*client_token*/,"cod"/*payment_list*/,model.getCartList));
// Response mapper = model.placeOrder(1/*merchant_id*/,"cod"/*transaction_type*/,"0dvgnimmnqh1wc52cee5764deecab20289679cba502dcf0"/*client_token*/,"cod"/*payment_list*/,json.encode(model.getCartList));
//   if(mapper.code > 0){
// print(' ################# from inside if code is equal :'+mapper.code.toString());
//   }else{
// print('################## from inside else code is equal :'+mapper.code.toString());
//   }
//   Alert(
//       context: context,
//       title: "ORDER DETAILS",
//       content: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               new Text(
//                 'Total Price: ${model.getCartPrice.toString()}',
//                 style: TextStyle(
//                     fontFamily: ArabicFonts.Cairo,
//                     package: 'google_fonts_arabic',
//                     color: Colors.grey,
//                     fontSize: 15),
//               )
//             ],
//           ),
//           Row(
//             children: <Widget>[
//               new Text(
//                 'Total Item: ${model.getCartList.length.toString()}',
//                 style: TextStyle(
//                     fontFamily: ArabicFonts.Cairo,
//                     package: 'google_fonts_arabic',
//                     color: Colors.grey,
//                     fontSize: 15),
//               )
//             ],
//           ),
//           Row(
//             children: <Widget>[
//               new Text(
//                 'Pyment method: Cash on delevery',
//                 style: TextStyle(
//                     fontFamily: ArabicFonts.Cairo,
//                     package: 'google_fonts_arabic',
//                     color: Colors.grey,
//                     fontSize: 15),
//               )
//             ],
//           ),
//         ],
//       ),
//       buttons: [
//         DialogButton(
//           onPressed: //() => _onChackBtnPressedOkay(context,model),
//           (){
//             print("#########################################################");
//             print(" modegetCartList" + model.getCartList.length.toString());
//           print("#########################################################");
//             print(model.placeOrder(1/*merchant_id*/,"cod"/*transaction_type*/,"0dvgnimmnqh1wc52cee5764deecab20289679cba502dcf0"/*client_token*/,"cod"/*payment_list*/,model.getCartList));
//           },
//           color: Colors.deepOrange,
//           child: Text(
//             "okay",
//             style: TextStyle(
//                 fontFamily: ArabicFonts.Cairo,
//                 package: 'google_fonts_arabic',
//                 color: Colors.white,
//                 fontSize: 20),
//           ),
//         ),
//         DialogButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             color: Colors.deepOrange,
//             child: Text(
//               "Cancel",
//               style: TextStyle(
//                   fontFamily: ArabicFonts.Cairo,
//                   package: 'google_fonts_arabic',
//                   color: Colors.white,
//                   fontSize: 20),
//             ))
//       ]).show();
// }
