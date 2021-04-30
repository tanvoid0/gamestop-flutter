import 'package:flutter/material.dart';

void toast(String message, BuildContext context){
  final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Okay',
        onPressed: () {
        },
      )
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}