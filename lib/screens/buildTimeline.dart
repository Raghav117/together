import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:together/design/styles.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:together/modals/models.dart';
import 'package:together/screens/video.dart';

class BuildTimeline extends StatefulWidget {
  final timeline;
  final bool homepage;

  const BuildTimeline({Key key, this.timeline, this.homepage})
      : super(key: key);
  @override
  _BuildTimelineState createState() => _BuildTimelineState(timeline);
}

class _BuildTimelineState extends State<BuildTimeline> {
  final List<Profile> timeline;

  _BuildTimelineState(this.timeline);

  @override
  void dispose() {
    print("uea");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          widget.homepage == true ? "Together" : "Posts",
          style: appName,
        ),
        centerTitle: widget.homepage == true ? true : false,
      ),
      body: Column(
        children: <Widget>[
          // Container(
          //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
          //     BoxShadow(
          //         color: Colors.black.withOpacity(0.1),
          //         spreadRadius: 0.5,
          //         offset: Offset(2.0, 0.5))
          //   ]),
          //   height: height / 16,
          //   child: Center(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: <Widget>[
          //         Text(
          //           "  Together",
          //           style: appName,
          //         ),
          //         Row(
          //           children: <Widget>[
          //             IconButton(
          //               onPressed: () {},
          //               icon: Icon(Icons.search),
          //             ),
          //             IconButton(
          //               onPressed: () {},
          //               icon: Icon(Icons.notifications),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // buildList(width, height)
          Flexible(
            child: ListView.builder(
              itemCount: timeline.length,
              itemBuilder: (BuildContext context, int index) {
                return buildList(width, height, index);
              },
            ),
          )
        ],
      ),
    );
  }

  Padding buildList(double width, double height, int i) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60,
              // color: Colors.white,
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          Own().imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "   " + Own().name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 30,
                          width: width / 1.5,
                          child: Text("   "),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.keyboard_arrow_down, size: 25),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  content: Container(
                                    height: width / 1.5,
                                    child: Column(
                                      children: <Widget>[
                                        FlatButton(
                                          child: Text("Report..."),
                                          onPressed: () {},
                                        ),
                                        FlatButton(
                                          child: Text("Mute..."),
                                          onPressed: () {},
                                        ),
                                        FlatButton(
                                          child: Text("Turn On Notification"),
                                          onPressed: () {},
                                        ),
                                        FlatButton(
                                          child: Text("Copy Link"),
                                          onPressed: () {},
                                        ),
                                        FlatButton(
                                          child: Text("Save Post"),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: LimitedBox(
                      child: Text(
                    timeline[i].text,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                timeline[i].purl.length == 1
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            child: Image.network(
                              "https://images.unsplash.com/photo-1517408191923-f82a669f4ea1?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : timeline[i].purl.length > 1
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                                height: height / 1.5,
                                width: width,
                                decoration: BoxDecoration(
                                    // color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Swiper(
                                  // autoplay: true,
                                  // duration: 2,
                                  pagination: SwiperPagination.dots,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      timeline[i].purl[index],
                                      fit: BoxFit.contain,
                                    );
                                  },
                                  itemCount: timeline[i].purl.length,
                                )))
                        : Container(),
                timeline[i].vurl.length > 0
                    ? VideoEidget(
                        url: timeline[i].vurl,
                        aspect: true,
                      )
                    : Container(),
                Container(
                  // height: 50,
                  decoration: BoxDecoration(
                      // color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.thumb_up,
                                  color: Colors.grey, size: 15),
                              // Text("Like", style: TextStyle(fontSize: 10)
                              // )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.chrome_reader_mode,
                                  color: Colors.grey, size: 15),
                              // Text("Comments", style: TextStyle(fontSize: 10)
                              // )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          onPressed: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.check_circle_outline,
                                  color: Colors.grey, size: 15),
                              // Text("WRT", style: TextStyle(fontSize: 10)
                              // )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
