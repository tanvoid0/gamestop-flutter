import 'package:flutter/material.dart';
import 'package:gamestop/helper/validator.dart';
import 'package:gamestop/style/theme.dart';
import 'package:gamestop/widgets/widgets.dart';

class PasswordFormField extends StatelessWidget {
  final IconData icon;
  final Function onSaved;
  const PasswordFormField({
    Key key,
    this.icon = Icons.lock,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        validator: (value) => passwordValidator(value),
        onSaved: (value) => onSaved(value),
        cursorColor: primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: primaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: primaryColor,
          ),
          border: InputBorder.none,
          hintText: "Password",
        ),
      ),
    );
  }
}
