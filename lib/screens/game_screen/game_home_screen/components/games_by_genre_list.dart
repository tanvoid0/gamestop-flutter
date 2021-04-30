import 'package:flutter/material.dart';
import 'package:gamestop/model/model.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/style/theme.dart';
import 'package:provider/provider.dart';

import 'games_list_view.dart';

class GamesByGenreList extends StatefulWidget {
  final gamesByGenre;

  GamesByGenreList({Key key, @required this.gamesByGenre}) : super(key: key);

  @override
  _GamesByGenreListState createState() => _GamesByGenreListState(gamesByGenre);
}

class _GamesByGenreListState extends State<GamesByGenreList>
    with SingleTickerProviderStateMixin {
  Map<String, List<Game>> gamesByGenre;
  _GamesByGenreListState(this.gamesByGenre);
  TabController _tabController;
  var genres;

  @override
  void initState() {
    super.initState();
    setState(() {
      genres = gamesByGenre.keys.toList();
    });
    _tabController = TabController(length: genres.length, vsync: this);
    _tabController.addListener(() {
      // if (_tabController.indexIsChanging) {
      //   print("Changing");
      // }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: primaryColor,
          appBar: PreferredSize(
            child: AppBar(
              backgroundColor: primaryColor,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: secondaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                unselectedLabelColor: textColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: genres.map<Widget>((String genre) {
                  return Container(
                      padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                      child: Text(genre.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          )));
                }).toList(),
              ),
            ),
            preferredSize: Size.fromHeight(50.0),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: genres.map<Widget>((String genre) {
              final games = Provider.of<Games>(context).gamesByGenre[genre];
              return GamesListView(
                games: games,
                fetchList: () async {
                  return Provider.of<Games>(context, listen: false)
                      .fetchServerGames();
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
