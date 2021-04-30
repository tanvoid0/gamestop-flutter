import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gamestop/screens/game_screen/game_search_screen/game_search_screen.dart';
import 'package:gamestop/style/theme.dart';

class CustomAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  CustomAppBar({Key key, this.scaffoldKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(EvaIcons.menu2Outline, color: whiteColor),
        onPressed: () {
          scaffoldKey.currentState.openDrawer();
        },
      ),
      title: Text("Gamestop"),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(GameSearchScreen.routeName);
          },
          icon: Icon(EvaIcons.searchOutline, color: whiteColor),
        ),
      ],
    );
  }
}
