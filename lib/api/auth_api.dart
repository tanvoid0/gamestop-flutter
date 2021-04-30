import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gamestop/data/constants.dart';

class AuthApi {
  static final login_url = "$server/auth/login";
  static final register_url = "$server/auth/register";
  static Dio _dio = Dio();

  static Future<Response> login(String email, String password) async {
    try {
      final response = await _dio.post(
        login_url,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) return response;
    } on DioError catch (error) {
      throw AuthException.fromMap(json.decode(error.response.toString()));
    }
  }

  static Future<Response> register(
      {String name, String email, String password, String password2}) async {
    try {
      final response = await _dio.post(
        register_url,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password2": password2,
        },
      );
      print(response.data);
      if (response.statusCode == 200) return response;
    } on DioError catch (error) {
      throw AuthException.fromMap(json.decode(error.response.toString()));
    }
  }
}

class AuthException {
  AuthException(
      {this.name, this.email, this.password, this.password2, this.auth});

  final String name;
  final String email;
  final String password;
  final String password2;
  final String auth;

  factory AuthException.fromJson(String str) =>
      AuthException.fromMap(json.decode(str));

  factory AuthException.fromMap(Map<String, dynamic> json) => AuthException(
        name: json['name'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        password2: json['password2'] as String,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'password': password,
        'password2': password2,
      };
}
