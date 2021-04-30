import 'package:flutter/material.dart';

class InfoDetail extends StatelessWidget {
  final String title;
  final Widget widget;
  InfoDetail({Key key, @required this.title, @required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headline6),
            widget,
          ],
        ));
  }
}
