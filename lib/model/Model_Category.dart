class Model_Category {
  final int merchant_id;
  final int cat_id;
  final String category_name;
  final String category_description;
  final String photo;

  Model_Category(
      {this.merchant_id,
      this.cat_id,
      this.category_name,
      this.category_description,
      this.photo});

  factory Model_Category.fromJson(Map<String, dynamic> json) {
    return Model_Category(
        merchant_id: json['merchant_id'] as int,
        cat_id: json['cat_id'] as int,
        category_name: json['category_name'] as String,
        category_description: json['category_description'] as String,
        photo: json['photo'] as String);
  }
}
