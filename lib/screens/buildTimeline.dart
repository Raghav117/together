import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';
import 'package:together/design/styles.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:together/modals/details.dart';
import 'package:together/modals/models.dart';
import 'package:together/screens/buildScreen.dart';
import 'package:together/screens/video.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'buildProfile.dart';

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
  bool loading;
  List<Profile> homeTimeline;
  _BuildTimelineState(this.timeline);

  @override
  void initState() {
    loading = true;
    super.initState();
    homeTimeline = List();
    if (widget.homepage == true) {
      func();
    }
  }

  func() async {
    var x = giveGeocode(Own().m, 5);
    print("yaeah");
    print(x);

    Firestore.instance.collection(x[8]).getDocuments().then((value) {
      print(value.documents.length);
      value.documents.forEach((element) {
        homeTimeline.add(Profile.fromaMap(element.data));
      });
    }).whenComplete(() {
      print(homeTimeline.length);
      loading = false;
      setState(() {});
    });
    setState(() {});
  }

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
        title: widget.homepage == true
            ? InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return BuildProfile(
                        phone: Own().phone,
                      );
                    },
                  ));
                },
                child: Text(
                  "Together",
                  style: appName,
                ),
              )
            : Text(
                "Posts",
                style: appName,
              ),
        // centerTitle: widget.homepage == true ? true : false,
      ),
      body: loading == false
          ? Column(
              children: <Widget>[
                Flexible(
                  child: ListView.builder(
                    itemCount: homeTimeline.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildList(width, height, index, homeTimeline);
                    },
                  ),
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Padding buildList(
      double width, double height, int i, List<Profile> timeline) {
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
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightBlueAccent.withOpacity(0.1)),
                        child: timeline[i].imageUrl.length != 0
                            ? InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) {
                                      return Scaffold(
                                        body: Center(
                                            child: Image.network(
                                                timeline[i].imageUrl)),
                                      );
                                    },
                                  ));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: timeline[i].imageUrl,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : Icon(
                                Icons.account_box,
                                color: Colors.lightBlueAccent,
                              ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return BuildProfile(
                                //!------------------------- ToDo ---------------------------------------------
                                phone: timeline[i].phone,
                              );
                            },
                          ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "   " + timeline[i].name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              // height: 30,
                              width: width / 1.5,
                              padding: EdgeInsets.only(left: 10),
                              // color: Colors.amber,
                              child: AutoSizeText(
                                  // "   Know by name and have a curisity to change the workd",
                                  timeline[i].userid,
                                  overflow: TextOverflow.ellipsis,
                                  minFontSize: 5),
                            ),
                            Text(
                              "    " + timeline[i].date,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.lightBlueAccent),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.keyboard_arrow_down, size: 25),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    content: Container(
                                      height: width,
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
                                          FlatButton(
                                            child: Text("Download it"),
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
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 5),
                  child: LimitedBox(
                      child: AutoSizeText(
                    timeline[i].text,
                  )),
                ),
                timeline[i].purl.length == 1
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: PinchZoomImage(
                            image: CachedNetworkImage(
                              imageUrl: timeline[i].purl[0],
                              placeholder: (context, url) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              // fit: BoxFit.contain,
                            ),
                            // hideStatusBarWhileZooming: true,
                            // onZoomStart: (value) {
                            //   print(value);
                            // },
                          ),
                        ),
                      )
                    : timeline[i].purl.length > 1
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                                height: width,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    // Colors.lightBlueAccent.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Swiper(
                                  // onTap: (index) async {
                                  //   Navigator.of(context)
                                  //       .push(MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return MakeScreen(
                                  //         p: timeline[i],
                                  //       );
                                  //     },
                                  //   ));
                                  // await Navigator.of(context)
                                  //     .push(MaterialPageRoute(
                                  //   fullscreenDialog: true,
                                  //   builder: (context) {
                                  //     return Scaffold(
                                  //       backgroundColor: Colors.transparent,
                                  //       body: Container(
                                  //         child: Center(
                                  //           child: CachedNetworkImage(
                                  //             imageUrl:
                                  //                 timeline[i].purl[index],
                                  //             placeholder: (context, url) {
                                  //               return Center(
                                  //                 child:
                                  //                     CircularProgressIndicator(),
                                  //               );
                                  //             },
                                  //             fit: BoxFit.contain,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  // ));
                                  // },

                                  pagination: SwiperPagination.dots,
                                  // layout: SwiperLayout.STACK,
                                  // itemWidth: width,
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Center(
                                        child: PinchZoomImage(
                                          image: CachedNetworkImage(
                                            imageUrl: timeline[i].purl[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: timeline[i].purl.length,
                                )))
                        : Container(),
                timeline[i].vurl.length > 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: VideoEidget(
                          url: timeline[i].vurl,
                          aspect: true,
                          doubletab: false,
                        ),
                      )
                    : Container(),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                              Text("123", style: TextStyle(fontSize: 10))
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
                              Text("235", style: TextStyle(fontSize: 10))
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
                              Text("Support", style: TextStyle(fontSize: 10))
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
