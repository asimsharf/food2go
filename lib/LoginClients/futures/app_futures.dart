import 'dart:async';
import 'dart:convert';

import 'package:food2go/LoginClients/utils/app_shared_preferences.dart';
import 'package:food2go/model/MazzayaResponse.dart';
import 'package:http/http.dart' as http;

import '../models/ApiRequest.dart';
import '../models/ApiResponse.dart';
import '../models/User.dart';
import '../models/base/EventObject.dart';
import '../utils/constants.dart';

///////////////////////////////////////////////////////////////////////////////

Future<EventObject> loginUser(String userEmail, String password) async {
  ApiRequest apiRequest = new ApiRequest();

  apiRequest.operation = APIOperations.LOGIN;
  try {
    final response = await http.get(
        'http://mazzaya.net/restomax/mobileapp/api/Login?email_address=' +
            userEmail +
            '&password=' +
            password,
        headers: {"Accept": "application/json"});

    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        final responseJson = json.decode(response.body);
        MazzayaResponse apiResponse = MazzayaResponse.fromJson(responseJson);
        Details details;
        Requester requester;
        if (apiResponse.code == 1) {
          details = Details.fromJson(apiResponse.details);
          requester = Requester.fromJson(apiResponse.requester);
          AppSharedPreferences.setInSession(
              'userName', details.client_name_cookie);
          AppSharedPreferences.setInSession('userToken', details.token);
          AppSharedPreferences.setInSession('userAvatar', details.avatar);
          AppSharedPreferences.setInSession(
              'userEmail', requester.email_address);
          return new EventObject(id: 1, object: apiResponse);
        } else if (apiResponse.code == 2) {
          return new EventObject(id: 2, object: apiResponse);
        } else {
          return new EventObject(id: 3, object: apiResponse);
        }
      } else {
        return new EventObject(id: 4);
      }
    } else {
      return new EventObject();
    }
  } catch (Exception) {
    print(Exception);
    return EventObject();
  }
}

///////////////////////////////////////////////////////////////////////////////
Future<EventObject> registerUser(
    String firstName,
    String lastName,
    String contactPhone,
    String emailAddress,
    String password,
    String cpassword) async {
  ApiRequest apiRequest = new ApiRequest();
  apiRequest.operation = APIOperations.REGISTER;

  try {
    final response = await http.get(
        'http://mazzaya.net/restomax/mobileapp/api/Signup?first_name=' +
            firstName +
            '&last_name=' +
            lastName +
            '&contact_phone=' +
            contactPhone +
            '&email_address=' +
            emailAddress +
            '&password=' +
            password +
            '&cpassword=' +
            cpassword,
        headers: {"Accept": "application/json"});

    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        final responseJson = json.decode(response.body);
        MazzayaResponse apiResponse = MazzayaResponse.fromJson(responseJson);

        if (apiResponse.code == 1) {
          AppSharedPreferences.deleteFromSession('userName');
          AppSharedPreferences.deleteFromSession('userToken');
          AppSharedPreferences.deleteFromSession('userAvatar');
          AppSharedPreferences.deleteFromSession('userEmail');

          return new EventObject(id: 1, object: apiResponse);
        } else if (apiResponse.code == 2) {
          return new EventObject(id: 2, object: apiResponse);
        } else {
          return new EventObject(id: 3, object: apiResponse);
        }
      } else {
        return new EventObject(id: 4);
      }
    } else {
      return new EventObject();
    }
  } catch (Exception) {
    return EventObject();
  }
}

///////////////////////////////////////////////////////////////////////////////
Future<EventObject> changePassword(
    String emailId, String oldPassword, String newPassword) async {
  ApiRequest apiRequest = new ApiRequest();
  User user = new User(
      email: emailId, old_password: oldPassword, new_password: newPassword);

  apiRequest.operation = APIOperations.CHANGE_PASSWORD;
  apiRequest.user = user;

  try {
    final encoding = APIConstants.OCTET_STREAM_ENCODING;
    final response = await http.post(APIConstants.API_BASE_URL,
        body: json.encode(apiRequest.toJson()),
        encoding: Encoding.getByName(encoding));
    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        final responseJson = json.decode(response.body);
        ApiResponse apiResponse = ApiResponse.fromJson(responseJson);
        if (apiResponse.result == APIOperations.SUCCESS) {
          return new EventObject(
              id: EventConstants.CHANGE_PASSWORD_SUCCESSFUL, object: null);
        } else if (apiResponse.result == APIOperations.FAILURE) {
          return new EventObject(id: EventConstants.INVALID_OLD_PASSWORD);
        } else {
          return new EventObject(
              id: EventConstants.CHANGE_PASSWORD_UN_SUCCESSFUL);
        }
      } else {
        return new EventObject(
            id: EventConstants.CHANGE_PASSWORD_UN_SUCCESSFUL);
      }
    } else {
      return new EventObject();
    }
  } catch (Exception) {
    return EventObject();
  }
}
///////////////////////////////////////////////////////////////////////////////
