import 'package:flutter/material.dart';
import 'package:gamestop/helper/validator.dart';
import 'package:gamestop/style/theme.dart';
import 'package:gamestop/widgets/text_field_container.dart';

class EmailFormField extends StatelessWidget {
  final IconData icon;
  final Function onSaved;
  final Function validator;

  const EmailFormField({
    Key key,
    this.icon = Icons.person,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        validator: this.validator != null
            ? this.validator
            : (value) => emailValidator(value),
        onSaved: (value) => onSaved(value),
        cursorColor: primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: primaryColor,
          ),
          border: InputBorder.none,
          hintText: "Your Email",
        ),
      ),
    );
  }
}
