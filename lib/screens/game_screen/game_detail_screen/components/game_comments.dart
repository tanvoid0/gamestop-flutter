import 'package:flutter/material.dart';
import 'package:gamestop/model/model.dart';

class GameComments extends StatefulWidget {
  final String game_id;
  final List<Comment> comments;

  GameComments({Key key, this.game_id, this.comments}) : super(key: key);

  @override
  _GameCommentsState createState() =>
      _GameCommentsState(this.game_id, this.comments);
}

class _GameCommentsState extends State<GameComments> {
  final String game_id;
  final List<Comment> comments;

  _GameCommentsState(this.game_id, this.comments);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ExpansionTile(
          leading: Icon(Icons.comment),
          trailing: Text(comments.length.toString()),
          title: Text("Comments"),
          children: List<Widget>.generate(
            comments.length,
            (int index) => Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(comments[index].comment),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
