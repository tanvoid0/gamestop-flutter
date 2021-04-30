import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gamestop/model/model.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/screens/game_screen/game_search_screen/game_search_screen.dart';
import 'package:gamestop/style/theme.dart';
import 'package:gamestop/widgets/scaffold/app_drawer.dart';
import 'package:gamestop/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sliver_fab/sliver_fab.dart';

import '../../../widgets/games/banner_list.dart';
import 'components/games_by_genre_list.dart';

class GameHomeScreen extends StatefulWidget {
  static final routeName = "/game_home";

  const GameHomeScreen({Key key}) : super(key: key);

  @override
  _GameHomeScreenState createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Game> games;
  var gamesByGenre;

  @override
  Widget build(BuildContext context) {
    games = Provider.of<Games>(context).games;
    gamesByGenre = Provider.of<Games>(context).gamesByGenre;
    final List<String> images = games.map((game) => game.image).toList();
    final List<String> titles = games.map((game) => game.title).toList();

    return games == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Builder(
            builder: (context) => SliverFab(
              floatingPosition: FloatingPosition(right: 20.0),
              floatingWidget: Container(),
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: primaryColor,
                  expandedHeight: 200.0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: BannerList(images: images, titles: titles),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(10.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        GamesByGenreList(gamesByGenre: gamesByGenre),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
