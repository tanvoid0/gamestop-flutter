import 'package:flutter/material.dart';
import 'package:gamestop/helper/helper.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/screens/game_screen/comment_screen/comment_screen.dart';
import 'package:gamestop/screens/screens.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).user;
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Hello, ${user.name.toUpperCase()}"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.gamepad),
          //   title: Text("Games", style: TextStyle(color: Colors.black)),
          //   onTap: () {
          //     if (ModalRoute.of(context).settings.name !=
          //         GameHomeScreen.routeName) toast("Same", context);
          //     // Navigator.of(context).pushNamedAndRemoveUntil(
          //     //   GameHomeScreen.routeName,
          //     //   ModalRoute.withName(
          //     //     GameHomeScreen.routeName,
          //     //   ),
          //     // );
          //     Navigator.of(context).pop();
          //   },
          // ),

          if (user.isAdmin) Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Log out", style: TextStyle(color: Colors.black)),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
