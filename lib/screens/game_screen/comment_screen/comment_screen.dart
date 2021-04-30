import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamestop/helper/helper.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/widgets/comments/comments_list_view.dart';
import 'package:gamestop/style/theme.dart';
import 'package:intl/intl.dart';

class CommentScreen extends StatefulWidget {
  static const routeName = "/comment-list";

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    final games = Provider.of<Games>(context).games;
    final user = Provider.of<Auth>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text("Comments Approval"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: games.length,
          itemBuilder: (ctx, index) {
            final comments = games[index].comments;
            return ListView.builder(
                itemCount: comments.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (ctx2, i) {
                  return CommentsListView(
                      comments: comments, game_id: games[index].id, user: user);
                });
          },
        ),
      ),
    );
  }
}
