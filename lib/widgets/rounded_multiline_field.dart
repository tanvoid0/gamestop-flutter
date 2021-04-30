import 'package:flutter/material.dart';
import 'package:gamestop/style/theme.dart';
import 'package:gamestop/widgets/text_field_container.dart';

class RoundedMultilineField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final IconData suffixIcon;
  final ValueChanged<String> onChanged;
  final Function onSubmit;
  final TextEditingController controller;
  final bool enabled;
  const RoundedMultilineField({
    Key key,
    @required this.hint,
    this.icon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmit,
    this.controller,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: secondaryLightColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        enabled: enabled,
        controller: controller,
        // keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.go,
        maxLines: null,
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
              : IconButton(
                  icon: Icon(
                    enabled ? suffixIcon : Icons.refresh,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    onSubmit();
                  },
                ),
        ),
      ),
    );
  }
}
