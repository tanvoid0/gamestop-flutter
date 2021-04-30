import 'package:flutter/material.dart';

import 'components/body.dart';

class AuthScreen extends StatelessWidget {
  static final routeName = "/auth";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
