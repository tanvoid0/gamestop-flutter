import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gamestop/style/theme.dart';

class Screenshots extends StatelessWidget {
  List<String> screenshots;

  Screenshots(this.screenshots);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext ctx, int index) => Container(
        margin: EdgeInsets.all(5),
        child: Card(
          elevation: 10,
          color: primaryLightColor,
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            child: Container(
                color: primaryLightColor,
                // margin: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                        shape: BoxShape.rectangle,
                        image: screenshots[index] != null
                            ? DecorationImage(
                                image: NetworkImage(screenshots[index]),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: screenshots[index] != null
                          ? null
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(EvaIcons.filmOutline,
                                    color: Colors.white, size: 50.0)
                              ],
                            ),
                    )
                  ],
                )),
          ),
        ),
      ),
    ));
  }
}
