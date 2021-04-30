import 'package:flutter/material.dart';
import 'package:gamestop/style/theme.dart';
import 'package:gamestop/widgets/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final IconData suffixIcon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    @required this.hint,
    this.icon,
    this.suffixIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: primaryColor,
          ),
          hintText: hint,
          border: InputBorder.none,
          suffixIcon: suffixIcon == null
              ? null
              : Icon(
                  suffixIcon,
                  color: primaryColor,
                ),
        ),
      ),
    );
  }
}
