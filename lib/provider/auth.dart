import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gamestop/api/api.dart';
import 'package:gamestop/data/constants.dart';
import 'package:gamestop/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  DateTime _expiryDate;
  User _user;
  Timer _authTimer;

  String get token {
    print("Token check! ${_expiryDate}");
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _user.token != null) return _user.token;
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  User get user {
    return _user;
  }

  Future<void> _authenticate(
      String email, String password, Response response) async {
    try {
      Map<String, dynamic> responseData = response.data;
      _user = User.fromMap(responseData);
      print("user response: ${_user.expiresIn}");
      _expiryDate = _user.expiresIn;
      // print("Expiry date: ${_expiryDate}");
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'user': _user.toJson().toString(),
        },
      );
      prefs.setString(USER_DATA, userData);
    } catch (error) {
      print("Error, can't save to local storage");
      throw error;
    }
  }

  Future<void> register(
      {@required String name,
      @required String email,
      @required String password,
      @required String password2}) async {
    try {
      print("$name, $email, $password, $password2");

      final response = await AuthApi.register(
          name: name, email: email, password: password, password2: password2);
      _authenticate(email, password, response);
      // final response = await AuthApi.register(
      //     name: name, email: email, password: password, password2: password2);
      // print("Response: ${response.data}");
      // _authenticate(email, password, response);
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      print("Login initiated");
      final response = await AuthApi.login(email, password);
      _authenticate(email, password, response);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    try {
      print("Initiate auto login");
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey(USER_DATA)) {
        print("No local data!");
        return false;
      }
      final extractedUserData =
          json.decode(prefs.getString(USER_DATA)) as Map<String, Object>;
      final userData = User.fromJson(extractedUserData['user'] as String);
      // final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

      if (userData.expiresIn.isBefore(DateTime.now())) {
        print("Expired!");
        return false;
      }
      _user = User.fromJson(extractedUserData['user']);
      _expiryDate = userData.expiresIn;
      // print(
      //     "Expiry is before now!\nExp at: ${expiryDate}\nnow: ${DateTime.now()}\n Before: ${expiryDate.isBefore(DateTime.now())}");
      notifyListeners();
      _autoLogout();
      return true;
    } catch (error) {
      print("Error in auto logging in! $error");
    }
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    print("Time to expire: ${timeToExpiry}");
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> logout() async {
    _user = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
    print("Remove local authentication");
  }
}
