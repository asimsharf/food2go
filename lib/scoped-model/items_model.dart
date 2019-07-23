import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Item.dart';

class ProductsModel extends Model {
  List<Item> _cartList = [];
  SharedPreferences prefs;

  String reponse;
  String _Responsse = '';

  String baseUrl = 'http://mazzaya.net/restomax/mobileapp/api/';
  List<Item> get getCartList {
    return List.from(_cartList);
  }

  String get getResponse {
    return json.encode(_Responsse);
  }

/*######################################## Start of finshed Methods ##########################*/

  double get getCartPrice {
    double price = 0;
    getCartList.forEach((Item item) {
      price += item.price * item.qty;
    });
    return price;
  }

  double getItemPrice(int price, int qty) {
    return double.parse((price * qty).toString());
  }

  void addToCart(
      String id,
      String merchant_id,
      int qty,
      int price,
      String photo,
      String item_name,
      int discount,
      int category_id,
      List<String> ingredients,
      String note) {
    List<String> emptyList = [];

    Item item = new Item(id, merchant_id, qty, price, photo, item_name,
        emptyList, emptyList, ingredients, note, discount, category_id);

    if (_cartList.length == 0) {
      //cart is empty new item first one
      _cartList.add(item);
    } else {
      if (_cartList[_cartList.length - 1].merchant_id != merchant_id) {
        // new merchant only one merchat per order
        _cartList = [];
        _cartList.add(item);
      } else {
        // same merchant id okay to add
        _cartList.add(item);
      }
    }
    notifyListeners();
  }

  void deleteItemFromCart(Item item) {
    _cartList.remove(item);
    notifyListeners();
  }

  // saveInSession(String key , String value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if(prefs.setString( key , value) == null){
  //     return false;

  //   }
  //   return true;
  // }

  getFromSession(String key) async {
    final prefs = await SharedPreferences.getInstance();
    // obtainning shared preferences
    return prefs.getString(key);
  }

  removeFromSession(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    if (prefs.getString(key) == null) {
      return true;
    }
    return false;
  }

/*######################################## End of finshed Methods ##########################*/

  String placeOrder(int merchantId, String cart) {
    var token = getFromSession('client_token');
    var transactionType = getFromSession('transaction_type');
    var paymentList = getFromSession('paymentList');
    http.get(
      baseUrl +
          'PlaceOrder?client_token=' +
          token +
          '&merchant_id=' +
          merchantId.toString().trim() +
          '&transaction_type=' +
          transactionType +
          '&cart=' +
          cart +
          '&payment_list=' +
          paymentList,
      headers: {
        'Content-Type': 'application/json',
      },
    ).then(
      (response) {
        List data = json.decode(response.body);
        return """ ${json.encode(data[0].toString())} """; // this means multi lines of String
      },
    );
  }

  static Future<void> saveInSession(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
