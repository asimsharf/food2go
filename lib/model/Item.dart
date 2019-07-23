import 'dart:convert';

String allPostsToJson(List<Item> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}
List<Item> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Item>.from(jsonData.map((x) => Item.fromJson(x)));
}

class Item {
  String item_id;
  String merchant_id;
  int qty;
  int price;
  String photo = '';
  String item_name;
  List<String> sub_item;
  List<String> cooking_ref;
  List<String> ingredients;
  String order_notes;
  int discount;
  int category_id;


  Item(this.item_id,this.merchant_id, this.qty, this.price, this.photo, this.item_name,this.sub_item,this.cooking_ref,this.ingredients,this.order_notes,this.discount,this.category_id);

  List<Item> getItems(String str) {
    final jsonData = json.decode(str);
    return new List<Item>.from(jsonData.map((x) => Item.fromJson(x)));
  }

  factory Item.fromJson(Map<String, dynamic> json) => new Item(
    json["item_id"],
    json["merchant_id"],
    json["qty"],
    json["price"],
    json["photo"],
    json["item_name"],
    json["sub_item"],
    json["cooking_ref"],
    json["ingredients"],
    json["order_notes"],
    json["discount"],
    json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": item_id,
    "qty": qty,
    "price": price,
    "sub_item": sub_item,
    "cooking_ref": cooking_ref,
    "ingredients": ingredients,
    "order_notes": order_notes,
    "discount": discount,
    "category_id": category_id,
  };

}
