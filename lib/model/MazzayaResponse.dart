import 'dart:convert';

String allPostsToJson(List<MazzayaResponse> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

List<MazzayaResponse> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<MazzayaResponse>.from(jsonData.map((x) => MazzayaResponse.fromJson(x)));
}

class MazzayaResponse {
  int code;
  String msg;
  dynamic details;
  dynamic requester;
  
  MazzayaResponse(this.code,this.msg, this.details, this.requester);
  
  List<MazzayaResponse> getItems(String str) {
      final jsonData = json.decode(str);
      return new List<MazzayaResponse>.from(jsonData.map((x) => MazzayaResponse.fromJson(x)));
  }
  
  factory MazzayaResponse.fromJson(List<dynamic> json) => new MazzayaResponse(
    json[0]["code"],
    json[0]["msg"],
    json[0]["details"],
    json[0]["request"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "details": details,
    "request": requester,
  };

  }
  
class Details {
  String token;
  String avatar;
  String client_name_cookie;
  String contact_phone;

  Details(this.token,this.avatar, this.client_name_cookie, this.contact_phone);

  List<Details> getItems(String str) {
    final jsonData = json.decode(str);
    return new List<Details>.from(jsonData.map((x) => Details.fromJson(x)));
  }

  factory Details.fromJson(dynamic json) => new Details(
      json["token"],
      json["avatar"],
      json["client_name_cookie"],
      json["contact_phone"],
    );

  Map<String, dynamic> toJson() => {
      "token": token,
      "avatar": avatar,
      "client_name_cookie": client_name_cookie,
      "contact_phone": contact_phone,
  };

}

class Requester {

  String email_address;

  Requester(this.email_address);

  List<Requester> getItems(String str) {
    final jsonData = json.decode(str);
    return new List<Requester>.from(jsonData.map((x) => Requester.fromJson(x)));
  }

  factory Requester.fromJson(dynamic json) => new Requester(
    json["email_address"],
  );

  Map<String, dynamic> toJson() => {
    "email_address": email_address,
  };

}
