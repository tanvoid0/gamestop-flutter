import 'package:flutter/material.dart';
import 'package:gamestop/style/theme.dart';
import 'package:gamestop/widgets/text_field_container.dart';

class RoundedFormPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedFormPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: primaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: primaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
