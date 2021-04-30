import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gamestop/helper/toast.dart';
import 'package:gamestop/model/model.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/screens/game_screen/comment_screen/comment_box.dart';
import 'package:gamestop/screens/game_screen/game_detail_screen/components/game_comments.dart';
import 'package:gamestop/screens/game_screen/game_detail_screen/components/info_detail.dart';
import 'package:gamestop/screens/game_screen/game_detail_screen/components/screenshots.dart';
import 'package:gamestop/screens/game_screen/game_detail_screen/components/string_list.dart';
import 'package:gamestop/widgets/games/banner_list.dart';
import 'package:gamestop/screens/game_screen/game_home_screen/components/platform_icons.dart';
import 'package:gamestop/style/theme.dart';
import 'package:gamestop/widgets/video_player_screen.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../widgets/comments/comments_list_view.dart';
import 'components/genres_list.dart';

const img = ["lksdf", "skdfjsldk", "lskdfjsd", "3242342", "xfgdfg"];

class GameDetailScreen extends StatelessWidget {
  static const String routeName = "/gameDetailScreen";
  final GlobalKey<ScaffoldState> _gameDetailScaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final game_id = ModalRoute.of(context).settings.arguments as String;
    final user = Provider.of<Auth>(context).user;
    var game = Provider.of<Games>(context)
        .games
        .firstWhere((game) => game.id == game_id);

    return Scaffold(
      key: _gameDetailScaffoldKey,
      backgroundColor: primaryColor,
      body: Builder(
        builder: (context) => SliverFab(
          floatingPosition: FloatingPosition(right: 20.0),
          floatingWidget: Container(),
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: primaryColor,
              expandedHeight: 200.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  game.title.length > 40
                      ? game.title.substring(0, 37) + "..."
                      : game.title,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
                background: BannerList(images: game.screenshots),
                // Stack(
                //   children: <Widget>[
                //     // Container(
                //     //   decoration: BoxDecoration(
                //     //     shape: BoxShape.rectangle,
                //     //     image: DecorationImage(
                //     //       image: NetworkImage(game.image),
                //     //       fit: BoxFit.cover,
                //     //     ),
                //     //   ),
                //     //   child: Container(
                //     //     decoration: BoxDecoration(
                //     //       color: Colors.black.withOpacity(0.0),
                //     //     ),
                //     //   ),
                //     // ),
                //     BannerList(images: game.screenshots),
                //     Container(
                //       decoration: BoxDecoration(
                //         gradient: LinearGradient(
                //           begin: Alignment.bottomCenter,
                //           end: Alignment.topCenter,
                //           colors: [
                //             Colors.black.withOpacity(0.9),
                //             Colors.black.withOpacity(0.0),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(10.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            game.rating != null
                                ? game.rating.toString()
                                : '0' + " / 5",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5.0),
                          RatingBar.builder(
                            itemSize: 15.0,
                            initialRating:
                                game.rating == null ? 0 : game.rating,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              EvaIcons.star,
                              color: secondaryColor,
                            ),
                            unratedColor: textColor,
                            glowColor: textColor,
                            onRatingUpdate: (rating) {
                              Provider.of<Games>(context, listen: false)
                                  .postReview(rating, game.id, user)
                                  .then((success) {
                                if (!success) {
                                  toast("There was an error!", context);
                                } else {
                                  toast("Successful rated ${game.title}!",
                                      context);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(game.description,
                          style: Theme.of(context).textTheme.caption),
                    ),

                    InfoDetail(
                      title: "Platform",
                      widget: PlatformIcons(platforms: game.platforms),
                    ),
                    InfoDetail(
                      title: "Genres",
                      widget: GenresList(genres: game.genres),
                    ),
                    InfoDetail(
                      title: "Developers",
                      widget: StringList(strings: game.developers),
                    ),
                    InfoDetail(
                      title: "Release Date",
                      widget: Text(DateFormat('MMM d, y').format(game.released),
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    InfoDetail(
                        title: "Website",
                        widget: InkWell(
                            child: Text(game.website,
                                style: Theme.of(context).textTheme.caption),
                            onTap: () => launch(game.website))),
                    if (game.pcRequirements != null)
                      InfoDetail(
                        title: "PC Requirements",
                        widget: Column(
                          children: <Widget>[
                            if (game.pcRequirements.minimum != null)
                              Text(game.pcRequirements.minimum,
                                  style: Theme.of(context).textTheme.caption),
                            SizedBox(height: 10),
                            if (game.pcRequirements.recommended != null)
                              Text(game.pcRequirements.recommended,
                                  style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                      ),

                    InfoDetail(
                        title: "Comments",
                        widget: Column(children: [
                          CommentsListView(
                            comments: game.comments,
                            game_id: game.id,
                            user: user,
                          ),
                          CommentBox(game_id: game.id, user: user),
                        ])),

                    // if (game.screenshots != null)
                    //   InfoDetail(
                    //     title: "Images",
                    //     widget: Screenshots(game.screenshots),
                    //   ),
                    // if (game.comments != null)
                    //   GameComments(game_id: game.id, comments: game.comments),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
