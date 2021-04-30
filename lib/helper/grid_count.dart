import 'package:flutter/material.dart';

int gridCount(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  if (size.width <= 550)
    return 2;
  else if (size.width <= 768)
    return 3;
  else if (size.width <= 1024)
    return 4;
  else if (size.width <= 1280)
    return 5;
  else if (size.width <= 1400)
    return 6;
  else if (size.width <= 1680)
    return 7;
  else if (size.width <= 1920)
    return 8;
  else
    return 10;
}
