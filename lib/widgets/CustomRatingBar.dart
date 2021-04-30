import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gamestop/helper/helper.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/style/theme.dart';

class CustomRatingBar extends StatelessWidget {
  final double rating;
  final String game_id;
  const CustomRatingBar(
      {Key key, @required this.rating, @required this.game_id});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).user;

    return Row(
      children: <Widget>[
        Text(
          rating == null ? '0' : rating.toString(),
          style: TextStyle(
            color: secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 5.0,
        ),
        RatingBar.builder(
          itemSize: 15.0,
          initialRating: rating == null ? 0 : rating,
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
                .postReview(rating, game_id, user)
                .then((success) {
              if (!success) {
                toast("There was an error!", context);
              } else {
                toast("Review posted successfully!", context);
              }
            });
          },
        )
      ],
    );
  }
}
