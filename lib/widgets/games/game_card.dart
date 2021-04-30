import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gamestop/helper/grid_count.dart';
import 'package:gamestop/helper/helper.dart';
import 'package:gamestop/model/model.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/screens/game_screen/game_detail_screen/game_detail_screen.dart';
import 'package:gamestop/screens/game_screen/game_home_screen/components/platform_icons.dart';
import 'package:gamestop/style/theme.dart';
import 'package:gamestop/widgets/CustomRatingBar.dart';

class GameCardView extends StatelessWidget {
  final Game game;
  final bool create;

  GameCardView({Key key, @required this.game, this.create = false})
      : super(key: key);

  void createGame(BuildContext context, user) async {
    print("Started");
    Provider.of<Games>(context, listen: false)
        .createGame(game.id, user)
        .then((_) {
      toast("Game added successfully", context);
    }).onError((error, stackTrace) {
      toast(error, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final count = gridCount(context);
    final user = Provider.of<Auth>(context).user;
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
      ),
      elevation: 10.0,
      margin: EdgeInsets.all(10),
      child: Container(
        color: primaryLightColor,
        child: Hero(
          tag: game.id,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(GameDetailScreen.routeName, arguments: game.id);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                        shape: BoxShape.rectangle,
                        image: game.image == null
                            ? null
                            : DecorationImage(
                                image: NetworkImage(game.image),
                                fit: BoxFit.cover,
                              )),
                    child: game.image != null
                        ? null
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(EvaIcons.filmOutline,
                                  color: Colors.white, size: 50.0)
                            ],
                          ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  height: 80.0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  game.title,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.bodyText2,
                                )),
                            SizedBox(height: 5.0),
                            if (game.platforms != null)
                              PlatformIcons(platforms: game.platforms),

                            // ListView(
                            //   scrollDirection: Axis.horizontal,
                            //   children: game.platforms
                            //       .map((platform) => Text("H"))
                            //       .toList(),
                            // ),

                            CustomRatingBar(
                              rating: game.rating,
                              game_id: game.id,
                            ),
                          ],
                        ),
                      ),
                      if (user.isAdmin && this.create)
                        Container(
                          width: 20,
                          margin: EdgeInsets.only(right: 6.0),
                          child: IconButton(
                            onPressed: () => createGame(context, user),
                            icon: Icon(Icons.add, color: secondaryColor),
                            iconSize: 20.0,
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
