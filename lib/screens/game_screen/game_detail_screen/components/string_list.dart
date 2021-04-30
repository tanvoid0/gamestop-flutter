import 'package:flutter/material.dart';
import 'package:gamestop/style/theme.dart';

class StringList extends StatelessWidget {
  List<String> strings;

  StringList({Key key, @required this.strings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: strings
            .map((item) => Padding(
                  padding: EdgeInsets.all(2),
                  child: Container(
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: Text(
                            item,
                            style: Theme.of(context).textTheme.bodyText1,
                          ))),
                ))
            .toList());
  }
}
