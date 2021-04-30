import 'package:flutter/material.dart';
import 'package:gamestop/helper/helper.dart';
import 'package:gamestop/model/model.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/style/theme.dart';

class CommentBox extends StatefulWidget {
  String game_id;
  User user;
  CommentBox({Key key, @required this.game_id, @required this.user})
      : super(key: key);
  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  String comment;
  TextEditingController _commentController = new TextEditingController();
  bool _isLoading = false;

  void _postComment() {
    if (_commentController.text.length < 3) return null;

    setState(() {
      _isLoading = true;
    });
    Provider.of<Games>(context, listen: false)
        .postComment(_commentController.text, widget.game_id, widget.user)
        .then((success) {
      if (success) {
        setState(() {
          _commentController.clear();
        });
      } else {
        toast("There was an error!", context);
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: MediaQuery.of(context).size.width * .95,
      decoration: BoxDecoration(
        color: textColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        controller: _commentController,
        enabled: !_isLoading,
        cursorColor: Colors.white,
        textInputAction: TextInputAction.send,
        onSubmitted: (value) => _postComment(),
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(
            Icons.comment,
            color: Colors.white,
          ),
          hintText: "Type your comments!",
          hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
          suffixIcon: !_isLoading
              ? IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: _postComment,
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
