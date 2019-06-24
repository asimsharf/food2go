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
  int qty;
  int price;
  String photo = '';
  String item_name;

  Item(this.item_id, this.qty, this.price, this.photo, this.item_name);

  List<Item> getItems(String str) {
    final jsonData = json.decode(str);
    return new List<Item>.from(jsonData.map((x) => Item.fromJson(x)));
  }

  factory Item.fromJson(Map<String, dynamic> json) => new Item(
        json["item_id"],
        json["qty"],
        json["price"],
        json["photo"],
        json["item_name"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": item_id,
        "qty": qty,
        "price": price,
        "photo": photo,
        "item_name": item_name,
      };
}
