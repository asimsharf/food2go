import 'dart:convert';

String allPostsToJson(List<Responsse> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

List<Responsse> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Responsse>.from(jsonData.map((x) => Responsse.fromJson(x)));
}

class Responsse {
  int code;
  String msg;
  Details details;
  Request request;

  Responsse(this.code, this.msg, this.details, this.request);

  List<Responsse> getResponses(String str) {
    final jsonData = json.decode(str);
    return new List<Responsse>.from(jsonData.map((x) => Responsse.fromJson(x)));
  }

  factory Responsse.fromJson(Map<String, dynamic> json) => new Responsse(
        json["code"],
        json["msg"],
        json["details"],
        json["request"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "details": details,
        "request": request,
      };
}

class Details {
  String token;
  String next_steps;
  String has_addressbook;
  String avatar;
  String client_name_cookie;
  String contact_phone;
  String location_name;
  String default_address;
  String transaction_type;
  String show_mobile_number;
  String social_strategy;

  Details(
      token,
      next_steps,
      has_addressbook,
      avatar,
      client_name_cookie,
      contact_phone,
      location_name,
      default_address,
      transaction_type,
      show_mobile_number,
      social_strategy);

  List<Details> getResponses(String str) {
    final jsonData = json.decode(str);
    return new List<Details>.from(jsonData.map((x) => Details.fromJson(x)));
  }

  factory Details.fromJson(Map<String, dynamic> json) => new Details(
        json["token"],
        json["next_steps"],
        json["has_addressbook"],
        json["avatar"],
        json["client_name_cookie"],
        json["contact_phone"],
        json["location_name"],
        json["default_address"],
        json["transaction_type"],
        json["show_mobile_number"],
        json["social_strategy"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "next_steps": next_steps,
        "has_addressbook": has_addressbook,
        "avatar": avatar,
        "client_name_cookie": client_name_cookie,
        "contact_phone": contact_phone,
        "location_name": location_name,
        "default_address": default_address,
        "transaction_type": transaction_type,
        "show_mobile_number": show_mobile_number,
        "social_strategy": social_strategy,
      };
}

class Request {
  String email_address;
  String password;

  Request(this.email_address, this.password);

  List<Request> getResponses(String str) {
    final jsonData = json.decode(str);
    return new List<Request>.from(jsonData.map((x) => Request.fromJson(x)));
  }

  factory Request.fromJson(Map<String, dynamic> json) => new Request(
        json["email_address"],
        json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email_address": email_address,
        "password": password,
      };
}
