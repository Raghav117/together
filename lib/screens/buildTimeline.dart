import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:together/design/styles.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:together/modals/models.dart';
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
  List<Profile> homeTimeline;
  _BuildTimelineState(this.timeline);

  @override
  void initState() {
    super.initState();
    homeTimeline = List();
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
        leading: widget.homepage == true
            ? Own().imageUrl.length == 0
                ? Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF000080).withOpacity(0.9),
                          Colors.lightBlue
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                : Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return Scaffold(
                                    backgroundColor:
                                        Colors.lightBlueAccent.withOpacity(0.7),
                                    body: Center(
                                        child: Image.network(Own().imageUrl)),
                                  );
                                },
                              ));
                            },
                            child: Image.network(Own().imageUrl,
                                fit: BoxFit.cover))),
                  )
            : null,
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
      body: Column(
        children: <Widget>[
          widget.homepage == true
              ? StreamBuilder(
                  stream: Firestore.instance
                      .collection(Own().phone)
                      .document("timeline")
                      .collection("line")
                      .getDocuments()
                      .asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print("data");
                      snapshot.requireData.documents.forEach((element) {
                        homeTimeline.add(Profile.fromaMap(element));
                      });

                      return Flexible(
                        child: ListView.builder(
                          itemCount: homeTimeline.length,
                          itemBuilder: (context, index) {
                            return buildList(
                                width, height, index, homeTimeline);
                          },
                        ),
                      );
                    } else {
                      print("loading");
                      return Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    }
                  },
                )
              : Flexible(
                  child: ListView.builder(
                    itemCount: timeline.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildList(width, height, index, timeline);
                    },
                  ),
                )
        ],
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
                        decoration: BoxDecoration(shape: BoxShape.circle),
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
                                  borderRadius: BorderRadius.circular(5),
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
                                phone: "+918937063090",
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
                              // color: Colors.amber,
                              child: AutoSizeText(
                                "   Know by name and have a curisity to change the workd",
                                overflow: TextOverflow.ellipsis,
                              ),
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
                                            child: Text("Download Post"),
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
                          child: Container(
                            child: CachedNetworkImage(
                              imageUrl: timeline[i].purl[0],
                              placeholder: (context, url) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
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
                                height: width,
                                width: width,
                                decoration: BoxDecoration(
                                    color:
                                        Colors.lightBlueAccent.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Swiper(
                                  onTap: (index) async {
                                    await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) {
                                        return Scaffold(
                                          backgroundColor: Colors.transparent,
                                          body: Container(
                                            child: Center(
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    timeline[i].purl[index],
                                                placeholder: (context, url) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ));
                                  },
                                  pagination: SwiperPagination.dots,
                                  // layout: SwiperLayout.STACK,
                                  // itemWidth: width,
                                  itemBuilder: (context, index) {
                                    return CachedNetworkImage(
                                      imageUrl: timeline[i].purl[index],
                                      fit: BoxFit.contain,
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
