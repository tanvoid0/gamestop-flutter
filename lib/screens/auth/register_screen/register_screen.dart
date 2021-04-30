import 'package:flutter/material.dart';

import 'components/body.dart';

class RegisterScreen extends StatelessWidget {
  static final routeName = "/register";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
