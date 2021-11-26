

import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:maajabu/api/appurl.dart';
import 'package:maajabu/data/user_preference.dart';
import 'package:maajabu/model/appuser.dart';

enum Status{
  NOTLOGGEDIN,
  NOTREGISTERED,
  LOGGEDIN,
  REGISTERED,
  AUTHENTICATING,
  REGISTERING,
  LOGGEDOUT
}
class Authprovider with ChangeNotifier{
  Status _loggedInStatus = Status.NOTLOGGEDIN;
  Status _registeredInStatus = Status.NOTREGISTERED;
  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      
        'email': email,
        'password': password
      
    };
    _loggedInStatus = Status.AUTHENTICATING;
    notifyListeners();

    Response response = await post(
      AppUrl.login,
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData['data'];

      AppUser authUser = AppUser.fromJson(userData);

      UserPreference().saveUser(authUser);

      _loggedInStatus = Status.LOGGEDIN;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NOTLOGGEDIN;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }
  Future<Map<String, dynamic>> register(String firstname,
      String lastname, String address, String phone, String email, String password) async {

    final Map<String, dynamic> registrationData = {
      'user': {
        'firstname': firstname,
        'lastname':lastname,
        'address':address,
        'phone':phone,
        'email': email,
        'password': password,
      }
    };

    _registeredInStatus = Status.REGISTERING;
    notifyListeners();

    return await post(AppUrl.register,
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }
  static Future<FutureOr> onValue(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {

      var userData = responseData['data'];

      AppUser authUser = AppUser.fromJson(userData);

      UserPreference().saveUser(authUser);
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {

      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }

    return result;
  }
  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }



}