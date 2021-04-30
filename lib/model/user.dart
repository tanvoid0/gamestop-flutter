import 'dart:convert';

import 'package:gamestop/helper/helper.dart';
import 'package:gamestop/model/model.dart';
import 'package:geolocator/geolocator.dart';

class User {
  User({
    this.name,
    this.phone,
    this.avatar,
    this.id,
    this.email,
    this.password,
    this.isAdmin,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.expiresIn,
  });

  final String id;
  final String name;
  final String phone;
  final String avatar;
  final String email;
  final String password;
  final bool isAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime expiresIn;
  final String token;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"] == null ? null : json['name'],
        phone: json["phone"] == null ? null : json['phone'],
        avatar: json["avatar"] == null ? null : json['avatar'],
        email: json["email"],
        password: json["password"],
        isAdmin: json["isAdmin"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        token: json['token'],
        expiresIn: DateTime.parse(json['expiresIn']),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "avatar": avatar,
        "email": email,
        "password": password,
        "isAdmin": isAdmin,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "token": token,
        "expiresIn": expiresIn.toIso8601String(),
      };

  static Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
