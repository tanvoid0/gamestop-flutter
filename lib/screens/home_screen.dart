import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gamestop/model/model.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/screens/game_screen/comment_screen/comment_screen.dart';
import 'package:gamestop/screens/game_screen/game_home_screen/game_home_screen.dart';
import 'package:gamestop/screens/game_screen/game_search_screen/game_search_screen.dart';
import 'package:gamestop/screens/screens.dart';
import 'package:gamestop/style/theme.dart';
import 'package:gamestop/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final pages = [
    {
      'icon': Icons.movie,
      'page': GameHomeScreen(),
    },
    {
      'icon': Icons.search,
      'page': GameSearchScreen(),
    },

    // {
    //   'icon': Icons.comment,
    //   'page': CommentScreen(),
    // }
  ];
  int pageIndex = 0;

  var _isInit = true;
  var _isLoading = false;
  User user;

  loadGames() {
    setState(() {
      _isLoading = true;
      user = Provider.of<Auth>(context).user;

      try {
        if (Platform.isAndroid) {
          pages.add({
            'icon': Icons.map,
            'page': MapScreen(),
          });
        }
      } catch (e) {}

      if (user.isAdmin)
        pages.add({
          'icon': Icons.add,
          'page': GameAddScreen(),
        });
    });
    Provider.of<Games>(context, listen: false).initialFetch().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) loadGames();
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColor,
      drawer: AppDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: secondaryColor,
          items: pages
              .map((page) => Icon(page['icon'], color: Colors.white, size: 30))
              .toList(),
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          }),
      body: pages[pageIndex]['page'],
    );
  }
}
