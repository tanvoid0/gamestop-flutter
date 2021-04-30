import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gamestop/api/api.dart';
import 'package:gamestop/provider/auth.dart';
import 'package:gamestop/screens/auth/components/email_form_field.dart';
import 'package:gamestop/screens/auth/components/password_form_field.dart';
import 'package:gamestop/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'background.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;

  void _showErrorDialog(String message) {
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

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(_authData['email'], _authData['password']);
    } on HttpException catch (error) {
      print("Auth error: ${error}");
      _showErrorDialog("Authentication failed!");
    } on AuthException catch (error) {
      String errMsg = "Authentication failed!";
      AuthException authExp = error;
      if (authExp.email != null) {
        errMsg = authExp.email;
      } else if (authExp.password != null) {
        errMsg = authExp.password;
      } else if (authExp.password2 != null) {
        // print("Fuk it already");
        errMsg = authExp.password2;
      }
      // final errorResponse = json.decode(error.response);
      // if (error['email'] != '') {
      //   errorMessage = error['email'];
      //   print("email error");
      // } else if (error['password'] != '') {
      //   errorMessage = error['password'];
      //   print("password error");
      // }
      // print("Error message: ${error.response}");
      _showErrorDialog(errMsg);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              EmailFormField(
                onSaved: (value) {
                  _authData['email'] = value;
                },
              ),
              PasswordFormField(
                onSaved: (value) {
                  _authData['password'] = value;
                },
              ),
              if (_isLoading)
                CircularProgressIndicator()
              else
                RoundedButton(
                  text: "LOGIN",
                  press: _submit,
                ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        // return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
