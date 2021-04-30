import 'package:flutter/material.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/screens/game_screen/game_home_screen/components/games_list_view.dart';
import 'package:gamestop/style/theme.dart';

class GameAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final games = Provider.of<Games>(context).apiGames;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(title: Text("Browse Games")),
      body: GamesListView(
        games: games,
        create: true,
        fetchList: () async {
          await Provider.of<Games>(context, listen: false).fetchApiGames();
        },
      ),
    );
  }
}
