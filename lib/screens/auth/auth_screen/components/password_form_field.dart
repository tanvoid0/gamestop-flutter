import 'package:flutter/material.dart';
import 'package:gamestop/helper/helper.dart';
import 'package:gamestop/helper/validator.dart';
import 'package:gamestop/style/theme.dart';
import 'package:gamestop/widgets/widgets.dart';

class PasswordFormField extends StatefulWidget {
  final IconData icon;
  final Function onSaved;
  final Function validator;
  final bool enabled;
  final TextEditingController controller;
  const PasswordFormField({
    Key key,
    this.controller,
    this.enabled = true,
    this.icon = Icons.lock,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: widget.controller,
        enabled: widget.enabled,
        obscureText: _obscureText,
        validator: widget.validator,
        onSaved: (value) => widget.onSaved(value),
        cursorColor: primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: primaryColor,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          border: InputBorder.none,
          hintText: "Password",
        ),
      ),
    );
  }
}
