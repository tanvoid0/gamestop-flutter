import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gamestop/api/api.dart';
import 'package:gamestop/helper/helper.dart';
import 'package:gamestop/model/model.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/screens/game_screen/game_detail_screen/game_detail_screen.dart';
import 'package:gamestop/widgets/games/game_card.dart';
import 'package:gamestop/style/theme.dart';

import 'platform_icons.dart';

class GamesListView extends StatefulWidget {
  final List<Game> games;
  final bool create;
  final Function fetchList;

  GamesListView(
      {Key key, this.games, this.create = false, @required this.fetchList})
      : super(key: key);

  @override
  _GamesListViewState createState() => _GamesListViewState();
}

class _GamesListViewState extends State<GamesListView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (widget.games.length == 0)
      return Container(
        child: Center(
          child: Text("No games",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );
    else
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridCount(context),
        ),
        itemCount: widget.games.length + 1,
        primary: false,
        padding: const EdgeInsets.all(20.0),
        itemBuilder: (context, index) {
          if (index == widget.games.length) {
            if (isLoading)
              return CircularProgressIndicator();
            else
              return MaterialButton(
                shape: CircleBorder(),
                child: Icon(Icons.cloud_download, color: Colors.white),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  widget.fetchList();
                  await Future.delayed(Duration(seconds: 1));
                  setState(() {
                    isLoading = false;
                  });
                },
              );
          }

          return GameCardView(game: widget.games[index], create: widget.create);
        },
      );
  }
}
