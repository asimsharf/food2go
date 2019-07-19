import 'dart:convert';

import 'package:food2go/model/Response.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../model/Item.dart';
import '../model/Response.dart';

class ProductsModel extends Model {
  List<Item> _cartList = [];
  Responsse _reponsestr;
  String _Responsse = '';

  String baseUrl = 'http://mazzaya.net/restomax/mobileapp/api/';
  List<Item> get getCartList {
    return List.from(_cartList);
  }

  String get getResponse {
    return json.encode(_Responsse);
  }

//"item_id\": 14,\"qty\": 1,\"price\": \"100|\",\"sub_item\": [],\"cooking_ref\": [],\"ingredients\": [],\"order_notes\": \"\",\"discount\": 0,\"category_id\":
  List<String> cartToJson(List<Item> itemList) {
    List<String> cart = [];
    itemList.forEach((item) => {
          cart.add(item.toJson().toString()),
        });
    return cart;
  }

  double get getCartPrice {
    double price = 0;
    getCartList.forEach((Item item) {
      price += item.price * item.qty;
    });
    print('+++++++############################ price is :' + price.toString());
    return price;
  }

  double getItemPrice(int price, int qty) {
    print('+++++++############################ price is :' + price.toString());
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
    //new Item(id, merchant_id, qty, price, photo, item_name);
    if (_cartList.length == 0) {
      //cart is empty new item first one
      _cartList.add(item);
      print(
          '################################################ From inside method ');
    } else {
      if (_cartList[_cartList.length - 1].merchant_id != merchant_id) {
        // new merchant only one merchat per order
        _cartList = [];
        _cartList.add(item);
        print(
            '################################################ new merchant only one merchat per order ');
        print('################################################  ' +
            _cartList.toString());
      } else {
        // same merchant id okay to add
        _cartList.add(item);
        print(
            '################################################ same merchant id okay to add ');
        print('################################################  ' +
            _cartList.toString());
      }
    }
    notifyListeners();
  }

  void deleteItemFromCart(Item item) {
    _cartList.remove(item);
    notifyListeners();
  }

  String placeOrder(String merchant_id, String transaction_type,
      String client_token, String payment_list, String cart) {
    // json responsestring;
    var jsonData;
    var cartlist = json.encode(cart); //cartToJson(_cartList);
    http.get(
      baseUrl +
          'PlaceOrder?client_token=${client_token}&merchant_id=${merchant_id}&transaction_type=${transaction_type}&cart=${cart}&payment_list=${payment_list}',
      headers: {
        'Content-Type': 'application/json',
      },
    ).then(
      (response) {
        print('#############################' + response.body);
        this._Responsse = response.body;
        // jsonData = json.encode(response.toString());
        return json.encode(response.toString());
        print("Response body: ${json.decode(response.body).toString()}");
      },
    );
  }
}
