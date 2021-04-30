import 'package:flutter/material.dart';

// const primaryColor = Color(0xFF6F35A5);
const primaryColor = Color(0xFF151C26);
const primaryLightColor = Colors.black87;
const secondaryColor = Color(0xFF6F35A5);
const secondaryLightColor = Color(0xFFF1E6FF);
const textColor = Color(0xFF5A606B);
const whiteColor = Color(0xFFFFFFFF);
// const backgroundColor = Color(0xFF151C26);
const backgroundColor = Color(0xFFFFFFFF);

final themeData = ThemeData(
  primaryColor: primaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    bodyText1: TextStyle(color: whiteColor),
    bodyText2: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
    headline6: TextStyle(color: whiteColor),
    caption: TextStyle(color: textColor),
  ).apply(),
);
