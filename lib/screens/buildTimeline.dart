import 'package:flutter/material.dart';
import 'package:together/design/styles.dart';

class BuildTimeline extends StatefulWidget {
  @override
  _BuildTimelineState createState() => _BuildTimelineState();
}

class _BuildTimelineState extends State<BuildTimeline> {
  @override
  void dispose() {
    print("uea");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0.5,
                  offset: Offset(2.0, 0.5))
            ]),
            height: height / 16,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "  Together",
                    style: appName,
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return buildList(width);
              },
            ),
          )
        ],
      ),
    );
  }

  Padding buildList(double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              color: Colors.white,
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/profile.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "   " + "Kashish Dudeja",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 30,
                          width: width / 1.5,
                          child:
                              Text("   " + "dfkjs io fh;siu f;oei u tgasohy"),
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
            Container(
              height: 200,
              color: Colors.white,
            ),
            Container(
              height: 20,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.thumb_up,
                            size: 15,
                            color: Colors.blue,
                          ),
                          Text(
                            "  356",
                            style: TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "5 comments   ",
                        style: TextStyle(fontSize: 13),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Divider(
                height: 1,
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
            Container(
              height: 50,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.thumb_up, color: Colors.grey, size: 15),
                          Text("Like", style: TextStyle(fontSize: 10))
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
                          Text("Comments", style: TextStyle(fontSize: 10))
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
                          Icon(Icons.share, color: Colors.grey, size: 15),
                          Text("Share", style: TextStyle(fontSize: 10))
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
                          Text("WRT", style: TextStyle(fontSize: 10))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
