import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gamestop/screens/auth/auth_screen/components/auth_card.dart';
import 'package:gamestop/style/theme.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = "/auth";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              secondaryColor.withOpacity(0.5),
              secondaryLightColor.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1],
          ),
        ),
      ),
      SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                  // transform: Matrix4.rotationZ(-8 * pi / 180)
                  //   ..translate(-10.0),
                  // ..translate(-10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primaryColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black26,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Text(
                    'Gamestop',
                    style: TextStyle(
                      color: Theme.of(context).accentTextTheme.title.color,
                      fontSize: 35,
                      fontFamily: 'Anton',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Flexible(
                // flex: size.width > 600 ? 2 : 1,
                child: AuthCard(),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
