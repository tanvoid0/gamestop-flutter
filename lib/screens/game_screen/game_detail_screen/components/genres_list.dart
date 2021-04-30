import 'package:flutter/material.dart';
import 'package:gamestop/style/theme.dart';

class GenresList extends StatelessWidget {
  List<String> genres;

  GenresList({Key key, @required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: genres
            .map((item) => Padding(
                  padding: EdgeInsets.all(2),
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: secondaryColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          child: Text(
                            item,
                            style: Theme.of(context).textTheme.bodyText1,
                          ))),
                ))
            .toList());
  }
}
