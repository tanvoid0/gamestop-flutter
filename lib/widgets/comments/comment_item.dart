import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamestop/helper/helper.dart';
import 'package:gamestop/model/model.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/style/theme.dart';
import 'package:intl/intl.dart';

class CommentItem extends StatefulWidget {
  final Comment comment;
  final String game_id;
  final User user;

  CommentItem(
      {Key key,
      @required this.comment,
      @required this.game_id,
      @required this.user})
      : super(key: key);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool _approveLoading = false;
  bool _deleteLoading = false;

  void approveComment() async {
    setState(() {
      _approveLoading = true;
    });
    Provider.of<Games>(context, listen: false)
        .approveComment(widget.comment.id, widget.game_id, widget.user)
        .then((data) {
      setState(() {
        _approveLoading = false;
      });
    }).onError((error, stackTrace) {
      toast(error, context);
      setState(() {
        _approveLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50.0,
                width: 50.0,
                margin: EdgeInsets.only(top: 10.0),
                decoration: new BoxDecoration(
                    color: secondaryColor,
                    image: new DecorationImage(
                      image: new NetworkImage(
                        "http:" + widget.comment.user.avatar,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(50.0)),
                    border: new Border.all(
                      color: secondaryColor,
                      width: 5.0,
                    )),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Card(
                    elevation: 10,
                    color: primaryColor,
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: secondaryColor,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.comment.user.name.toUpperCase(),
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                      DateFormat("MMM d y").format(
                                        widget.comment.createdAt,
                                      ),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  SizedBox(height: 5.0),
                                  Text(
                                    widget.comment.comment,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Tooltip(
                                    message: widget.comment.approve
                                        ? "Approved"
                                        : "Not approved",
                                    child: MaterialButton(
                                      shape: CircleBorder(),
                                      color: widget.comment.approve
                                          ? Colors.green
                                          : Colors.red,
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        child: _approveLoading
                                            ? CircularProgressIndicator()
                                            : Icon(
                                                widget.comment.comment != null
                                                    ? Icons.fact_check
                                                    : Icons.fact_check_outlined,
                                                color: Colors.white,
                                              ),
                                      ),
                                      onPressed: widget.user.isAdmin
                                          ? approveComment
                                          : null,
                                    ),
                                  ),
                                  if (widget.user.isAdmin ||
                                      widget.comment.user.id == widget.user.id)
                                    MaterialButton(
                                      shape: CircleBorder(),
                                      color: Colors.red,
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        child: _deleteLoading
                                            ? CircularProgressIndicator()
                                            : Icon(
                                                FontAwesomeIcons.trashAlt,
                                                color: Colors.white,
                                              ),
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          _deleteLoading = true;
                                        });
                                        Provider.of<Games>(context,
                                                listen: false)
                                            .deleteComment(widget.comment.id,
                                                widget.game_id, widget.user)
                                            .then((data) {
                                          setState(() {
                                            _deleteLoading = false;
                                          });
                                        }).onError((error, stackTrace) {
                                          toast(error, context);
                                          setState(() {
                                            _deleteLoading = false;
                                          });
                                        });
                                      },
                                    ),
                                ])
                            // IconButton(icon: Icon(Icons.yes))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider(
            height: 10.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
