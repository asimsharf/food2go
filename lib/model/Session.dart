import 'dart:convert';

class UserSession {
  String client_name_cookie;
  String email_address;
  String token;
  bool is_login;

  UserSession(
      this.client_name_cookie, this.email_address, this.token, this.is_login);

  List<UserSession> getUserSession(String str) {
    final jsonData = json.decode(str);
    return new List<UserSession>.from(
        jsonData.map((x) => UserSession.fromJson(x)));
  }

  factory UserSession.fromJson(Map<String, dynamic> json) => new UserSession(
        json[0]['details']["client_name_cookie"],
        json[0]['request']["email_address"],
        json[0]['details']["token"],
        true,
      );

  Map<String, dynamic> toJson() => {
        "client_name_cookie": client_name_cookie,
        "email_address": email_address,
        "token": token,
        "is_login": is_login,
      };
}
