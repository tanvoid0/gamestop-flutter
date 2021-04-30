import 'package:flutter/material.dart';
import 'package:gamestop/api/api.dart';
import 'package:gamestop/helper/helper.dart';
import 'package:gamestop/model/model.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/style/theme.dart';
import 'package:gamestop/widgets/comments/comment_item.dart';
import 'package:gamestop/widgets/rounded_form_field.dart';
import 'package:gamestop/widgets/rounded_multiline_field.dart';
import 'package:gamestop/widgets/text_field_container.dart';
import 'package:gamestop/widgets/timeline.dart';
import 'package:intl/intl.dart';

class CommentsListView extends StatefulWidget {
  List<Comment> comments;
  String game_id;
  User user;

  CommentsListView(
      {Key key,
      @required this.comments,
      @required this.game_id,
      @required this.user})
      : super(key: key);

  @override
  _CommentsListViewState createState() => _CommentsListViewState();
}

class _CommentsListViewState extends State<CommentsListView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            new ListView.builder(
                itemCount: widget.comments.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, int i) {
                  return CommentItem(
                    comment: widget.comments[i],
                    game_id: widget.game_id,
                    user: widget.user,
                  );
                }),
          ],
        ));
  }
}
