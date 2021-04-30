import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/style/theme.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';

class BannerList extends StatefulWidget {
  final List<String> images;
  final List<String> titles;
  BannerList({Key key, @required this.images, this.titles}) : super(key: key);
  @override
  _BannerListState createState() => _BannerListState();
}

class _BannerListState extends State<BannerList> {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);
  @override
  Widget build(BuildContext context) {
    const height = 220.0;
    if (widget.images.length == 0)
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No games yet!",
                  style: TextStyle(color: Colors.black45),
                ),
              ],
            ),
          ],
        ),
      );
    else
      return Container(
        height: height,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          length: widget.images.take(5).length,
          indicatorSpace: 8.0,
          padding: const EdgeInsets.all(5.0),
          indicatorColor: textColor,
          indicatorSelectorColor: secondaryColor,
          shape: IndicatorShape.circle(size: 5.0),
          child: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.take(5).length,
            itemBuilder: (ctx, index) => GestureDetector(
              onTap: () {},
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: 'banner ' + widget.images[index],
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: height,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.images[index]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [
                          0.0,
                          0.9,
                        ],
                        colors: [
                          primaryColor.withOpacity(1.0),
                          primaryColor.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                  if (widget.titles != null)
                    Positioned(
                      bottom: 30.0,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        width: 250.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.titles[index],
                              style: TextStyle(
                                height: 1.5,
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
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
