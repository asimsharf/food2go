import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class AppSharedPreferences {
///////////////////////////////////////////////////////////////////////////////
  static Future<SharedPreferences> getInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

///////////////////////////////////////////////////////////////////////////////
  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool> deleteFromSession(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

///////////////////////////////////////////////////////////////////////////////
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferenceKeys.IS_USER_LOGGED_IN);
  }

  static Future<void> setUserLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(SharedPreferenceKeys.IS_USER_LOGGED_IN, isLoggedIn);
  }

  static Future<void> setPICKUP(bool isPickupTrue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('TRANSACTION_TYPE_IS_PICKUP', isPickupTrue);
  }

  static Future<void> setDELEVERY(bool isDeleveryTrue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('TRANSACTION_TYPE_IS_DELEVERY', isDeleveryTrue);
  }

///////////////////////////////////////////////////////////////////////////////
  static Future<Object> getFromSession(String str) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(str);
  }

  static Future<bool> setInSession(String key, String value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
