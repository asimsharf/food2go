class Model_Merchant {
  final String merchant_id;
  final String merchant_bg;
  final String restaurant_name;
  final String address;
  final String cuisine;
  final String delivery_fee;
  final String minimum_order;
  final String delivery_est;
  final String is_open;
  final String tag_raw;
  final String logo;
  final String offers;
  final String distance;
  final String service;
  //an objects
  final Services services;
  final String delivery_estimation;
  final String delivery_distance;
  final String is_sponsored;
  //an array
  final List<String> payment_available;
  //an objects
  final MapCoordinates map_coordinates;
  //an objects
  final PaymentOptions payment_options;
  //an objects
  final Ratings ratings;

  Model_Merchant(
      {this.merchant_id,
      this.merchant_bg,
      this.restaurant_name,
      this.address,
      this.cuisine,
      this.delivery_fee,
      this.minimum_order,
      this.delivery_est,
      this.is_open,
      this.tag_raw,
      this.logo,
      this.payment_available,
      this.offers,
      this.service,
      this.services,
      this.distance,
      this.delivery_estimation,
      this.delivery_distance,
      this.is_sponsored,
      this.map_coordinates,
      this.payment_options,
      this.ratings});

  factory Model_Merchant.fromJson(Map<String, dynamic> json) {
    return Model_Merchant(
      merchant_id: json['merchant_id'] as String,
      merchant_bg: json['merchant_bg'] as String,
      restaurant_name: json['restaurant_name'] as String,
      address: json['address'] as String,
      cuisine: json['cuisine'] as String,
      delivery_fee: json['delivery_fee'] as String,
      minimum_order: json['minimum_order'] as String,
      delivery_est: json['delivery_est'] as String,
      is_open: json['is_open'] as String,
      tag_raw: json['tag_raw'] as String,
      logo: json['logo'] as String,
      offers: json['offers'].toString() as String ?? "No Offers",
      service: json['service'] as String,
      services: Services.fromJson(json['services']),
      distance: json['distance'] as String,
      payment_available: parsepaymentAvailable(json['payment_available']),
      delivery_estimation: json['delivery_estimation'] as String,
      delivery_distance: json['delivery_distance'] as String,
      is_sponsored: json['is_sponsored'] as String,
      map_coordinates: MapCoordinates.fromJson(json['map_coordinates']),
      payment_options: PaymentOptions.fromJson(json['payment_options']),
      ratings: Ratings.fromJson(json['ratings']),
    );
  }

  static List<String> parsepaymentAvailable(payment_availableJson) {
    List<String> paymentAvailableList =
        new List<String>.from(payment_availableJson);
    return paymentAvailableList;
  }
}

/*  ******************************************** MapCoordinates ****************** */
class MapCoordinates {
  final String latitude;
  final String lontitude;

  MapCoordinates({this.latitude, this.lontitude});

  factory MapCoordinates.fromJson(Map<String, dynamic> json) {
    return MapCoordinates(
        latitude: json['latitude'] as String,
        lontitude: json['lontitude'] as String);
  }
}

/* ******************************************** PaymentOptions *********************** */
class PaymentOptions {
  final String code;
  final String online;

  PaymentOptions({this.code, this.online});

  factory PaymentOptions.fromJson(Map<String, dynamic> json) {
    return PaymentOptions(
      code: json['code'] as String,
      online: json['online'] as String,
    );
  }
}

/* ******************************************* Ratings ********************* */
class Ratings {
  final int ratings;
  final int votes;

  Ratings({this.ratings, this.votes});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
        ratings: json['ratings'] as int, votes: json['votes'] as int);
  }
}

/* ******************************************** Services ****************** */

class Services {
  final String delivery;
  final String pickup;
  final String dinein;

  Services({this.delivery, this.pickup, this.dinein});

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
        delivery: json['delivery'] as String,
        pickup: json['pickup'] as String,
        dinein: json['dinein'] as String);
  }
}
