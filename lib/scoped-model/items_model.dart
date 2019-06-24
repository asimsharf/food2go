// import 'package:foodtogo/model/Order.dart';
import 'package:scoped_model/scoped_model.dart';

import '../model/Item.dart';

class ProductsModel extends Model {
  List<Item> _cartList = [];
  // Model_Order order;
  String baseUrl = 'http://mazzaya.net/restomax/mobileapp/api/';
  List<Item> get getCartList {
    return List.from(_cartList);
  }

  double get getCartPrice {
    double price = 0;
    getCartList.forEach((Item item) {
      price += item.price * item.qty;
    });
    print('+++++++############################price is :' + price.toString());
    return price;
  }

  void addToCart(
      String id, int qty, int price, String photo, String item_name) {
    Item item = new Item(id, qty, price, photo, item_name);

    _cartList.add(item);
    print(
        '################################################ From inside method ');
    print('########### photo ${photo}');
    print('########### ID ${id}');
    print('########################### qty ${qty}');
    print('########################### price ${price}');
    notifyListeners();
  }

  void deleteItemFromCart(Item item) {
    _cartList.remove(item);
    notifyListeners();
  }

//   void placeOrder(int merchant_id, String transaction_type, String client_token, String payment_list, List<Item> cart) {
//         Model_Order order = new Model_Order( merchant_id, transaction_type, client_token, payment_list, cart);
//         print('#################################### an Order has been placed ....');
//     // _cartList.remove(item);
//  http.get(
//       baseUrl + 'PlaceOrder?client_token=${client_token}&merchant_id=${merchant_id}&transaction_type=${transaction_type}&cart=${cart}&payment_list=${payment_list}',
//       headers: {'Content-Type': 'application/json',},).then(
//       (response) {
//         print("Response status: ${response.statusCode}");
//         print("Response body: ${response.body}");
//       },
//     );
//   }

}
