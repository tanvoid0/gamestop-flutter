import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamestop/data/constants.dart';

class PlatformIcons extends StatelessWidget {
  final List<String> platforms;

  PlatformIcons({Key key, @required this.platforms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < platforms.length && i < 6; i++)
          Padding(
            padding: EdgeInsets.all(3),
            child: Icon(PLATFORMS[platforms[i]], color: Colors.white, size: 13),
          )
      ],
    );
  }
}
