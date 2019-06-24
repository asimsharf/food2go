class Model_Dishes {
  String item_id;
  String item_name;
  String item_description;
  String discount;
  String photo;
  String spicydish;
  String dish;
  int single_item;
  String single_details;
  String not_available;
  //Prices prices;
  final List<Prices> prices;

  Model_Dishes(
      {this.item_id,
      this.item_name,
      this.item_description,
      this.discount,
      this.photo,
      this.spicydish,
      this.dish,
      this.single_item,
      this.single_details,
      this.not_available,
      this.prices});

  factory Model_Dishes.fromJson(Map<String, dynamic> json) {
    var list = json['prices'] as List;
    List<Prices> pricesList = list.map((i) => Prices.fromJson(i)).toList();

    return Model_Dishes(
        item_id: json['item_id'] as String,
        item_name: json['item_name'] as String,
        item_description: json['item_description'] as String,
        discount: json['discount'] as String,
        photo: json['photo'] as String,
        spicydish: json['spicydish'] as String,
        dish: json['dish'] as String,
        single_item: json['single_item'] as int,
        single_details: json['single_details'].toString() as String,
        not_available: json['not_available'] as String,
        prices: pricesList);
  }
}

class Prices {
  String price;
  String size;
  String size_id;
  String size_trans;
  String price_pretty;

  Prices(
      {this.price,
      this.size,
      this.size_id,
      this.size_trans,
      this.price_pretty});

  factory Prices.fromJson(Map<String, dynamic> json) {
    return Prices(
      price: json['price'] as String,
      size: json['size'] as String,
      size_id: json['size_id'].toString() as String,
      size_trans: json['size_trans'] as String,
      price_pretty: json['price_pretty'] as String,
    );
  }
}
