import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:gamestop/api/api.dart';
import 'package:gamestop/model/model.dart';
import 'package:gamestop/screens/game_screen/game_home_screen/components/games_list_view.dart';
import 'package:gamestop/style/theme.dart';
import 'package:gamestop/widgets/widgets.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'dart:async';

class GameSearchScreen extends StatefulWidget {
  static final routeName = "/game-search-screen";

  @override
  _GameSearchScreenState createState() => _GameSearchScreenState();
}

class _GameSearchScreenState extends State<GameSearchScreen> {
  String query;
  TextEditingController controller;
  List<Game> games;
  Timer _debounce;
  bool _loading = false;
  SearchBar searchBar;

  searchGames(value) async {
    setState(() {
      query = value;
      _loading = true;
    });
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      GameApi.fetchSearchList(query).then((data) {
        setState(() {
          games = data;
          _loading = false;
        });
      });
    });
  }

  _GameSearchScreenState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: (value) {
          print("Working $value");
        },
        onChanged: (value) {
          searchGames(value);
        },
        onClosed: () {
          print("Closed!");
        },
        onCleared: () {
          print("Cleard!");
          setState(() {
            games = [];
          });
        },
        showClearButton: true,
        buildDefaultAppBar: buildAppBar);
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Search for Games'),
        actions: [searchBar.getSearchAction(context)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: searchBar.build(context),
      // AppBar(
      //   actions: <Widget>[
      //     IconButton(
      //       onPressed: () {
      //         query = "";
      //       },
      //       icon: Icon(Icons.search),
      //     )
      //   ],
      //   centerTitle: true,
      //   title: RoundedInputField(
      //     hint: "Search For games",
      //     onChanged: (value) {
      //       setState(() {
      //         query = value;
      //         _loading = true;
      //       });
      //       searchGames(value);
      //     },
      //   ),
      // ),
      body: games == null || _loading
          ? Center(
              child: query != null && _loading
                  ? CircularProgressIndicator()
                  : Text("Please type something"),
            )
          : GamesListView(games: games),
    );
  }
}
