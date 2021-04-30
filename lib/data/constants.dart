import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:flutter/material.dart";

const server = "http://192.168.0.2:3000/api";

enum AuthMode { Register, Login }

const USER_DATA = "user_data";

const PLATFORMS = {
  "PC": FontAwesomeIcons.windows,
  "PlayStation": FontAwesomeIcons.playstation,
  "Xbox": FontAwesomeIcons.xbox,
  "Nintendo": FontAwesomeIcons.gamepad,
  "Android": FontAwesomeIcons.android,
  "iOS": FontAwesomeIcons.mobileAlt,
  "Apple Macintosh": FontAwesomeIcons.apple,
  "Linux": FontAwesomeIcons.linux,
  "Web": FontAwesomeIcons.globe,
};
