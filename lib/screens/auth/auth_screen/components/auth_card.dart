import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gamestop/api/api.dart';
import 'package:gamestop/data/constants.dart';
import 'package:gamestop/helper/helper.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/screens/auth/auth_screen/components/name_form_field.dart';
import 'package:gamestop/screens/auth/auth_screen/components/password_form_field.dart';
import 'package:gamestop/style/theme.dart';
import 'package:gamestop/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'email_form_field.dart';

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    "name": "",
    "email": "",
    "password": "",
    "password2": "",
  };

  Map<String, String> _errors = {
    "name": "",
    "email": "",
    "password": "",
    "password2": "",
  };

  var _showPassword1 = false;
  var _showPassword2 = false;

  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        Provider.of<Auth>(context, listen: false)
            .login(
          _authData['email'],
          _authData['password'],
        )
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        }).catchError((err) {
          AuthException error = err;
          String errMsg = "Authentication failed!";
          if (error.email != null) {
            errMsg = error.email;
          } else if (error.password != null) {
            errMsg = error.password;
          }
          toast(errMsg, context);
          setState(() {
            _isLoading = false;
          });
        });
      } else {
        Provider.of<Auth>(context, listen: false)
            .register(
          name: _authData['name'],
          email: _authData['email'],
          password: _authData['password'],
          password2: _authData['password2'],
        )
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        }).catchError((err) {
          AuthException error = err;
          String errMsg = "Authentication failed!";
          if (error.email != null) {
            errMsg = error.email;
          } else if (error.password != null) {
            errMsg = error.password;
          }
          toast(errMsg, context);
          setState(() {
            _isLoading = false;
          });
        });
      }
    } on AuthException catch (authExp) {
      String errMsg = "Authentication failed!";
      if (authExp.name != null) {
        errMsg = authExp.name;
      } else if (authExp.email != null) {
        errMsg = authExp.email;
      } else if (authExp.password != null) {
        errMsg = authExp.password;
      } else if (authExp.password2 != null) {
        errMsg = authExp.password2;
      }
      toast(errMsg, context);
    } catch (e) {
      toast(e, context);
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Register;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  double adjust_height() {
    return _authMode == AuthMode.Register ? 650 : 350;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        child: Container(
          // height: adjust_height(),
          // constraints: BoxConstraints(
          //   minHeight: adjust_height(),
          // ),
          width: size.width * 0.75,
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    _authMode == AuthMode.Register ? "Register" : "LOGIN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 20.0,
                    ),
                  ),
                  if (_authMode == AuthMode.Register)
                    NameFormField(
                      onSaved: (value) {
                        _authData['name'] = value;
                      },
                      // validator: (value) {
                      //   final err = nameValidator(value);
                      //   if (err != null) return err;
                      //   if (_errors['name'] != null) return _errors['name'];
                      // },
                    ),
                  EmailFormField(
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                    // validator: (value) {
                    //   final err = emailValidator(value);
                    //   if (err != null) return err;
                    //   if (_errors['email'] != null) return _errors['email'];
                    // },
                  ),
                  PasswordFormField(
                    controller: _passwordController,
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                    // validator: (value) {
                    //   final err = passwordValidator(value);
                    //   if (err != null) return err;
                    //   if (_errors['password'] != null)
                    //     return _errors['password'];
                    // },
                  ),
                  if (_authMode == AuthMode.Register)
                    PasswordFormField(
                      enabled: _authMode == AuthMode.Register,
                      onSaved: (value) {
                        _authData['password2'] = value;
                      },
                      validator: _authMode == AuthMode.Register
                          ? (value) {
                              return value != _passwordController.text
                                  ? 'Passwords do not match!'
                                  : null;
                            }
                          : null,
                    ),
                  // TextFormField(
                  //   enabled: _authMode == AuthMode.Register,
                  //   decoration:
                  //       InputDecoration(labelText: 'Confirm Password'),
                  //   obscureText: true,
                  //   validator: _authMode == AuthMode.Register
                  //       ? (value) {
                  //           return value != _passwordController.text
                  //               ? 'Passwords do not match!'
                  //               : null;
                  //         }
                  //       : null,
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    // RaisedButton(
                    //   child: Text(
                    //       _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    //   onPressed: _submit,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(30),
                    //   ),
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    //   color: Theme.of(context).primaryColor,
                    //   textColor:
                    //       Theme.of(context).primaryTextTheme.button.color,
                    // ),
                    RoundedButton(
                      text: _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                      press: _submit,
                    ),
                  FlatButton(
                    child: Text(
                        '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                    onPressed: _switchAuthMode,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
