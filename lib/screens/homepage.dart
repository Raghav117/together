import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:together/design/styles.dart';
import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  bool more;
  double height, width;
  bool post;
  @override
  void initState() {
    post = false;
    more = false;
    super.initState();
  }

  final items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.home, color: Colors.blue),
      icon: Icon(
        Icons.home,
        color: Colors.grey,
      ),
      title: Text("Timeline"),
    ),
    BottomNavigationBarItem(
        activeIcon: Icon(Icons.message, color: Colors.blue),
        icon: Icon(
          Icons.message,
          color: Colors.grey,
        ),
        title: Text("Messsage")),
    BottomNavigationBarItem(
        activeIcon: Icon(Icons.add, color: Colors.blue),
        icon: Icon(
          Icons.add,
          color: Colors.grey,
        ),
        title: Text("Post")),
    // BottomNavigationBarItem(
    //     activeIcon: Icon(Icons.notifications, color: Colors.blue),
    //     icon: Icon(
    //       Icons.notifications,
    //       color: Colors.grey,
    //     ),
    //     title: Text("Notification")),
    BottomNavigationBarItem(
        activeIcon: Icon(Icons.supervisor_account, color: Colors.blue),
        icon: Icon(
          Icons.supervisor_account,
          color: Colors.grey,
        ),
        title: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: ScrollBottomNavigationBar(
        controller: controller,
        items: items,
      ),
      backgroundColor: Colors.white.withOpacity(0.90),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.assignment_turned_in),
      // ),
      body: SafeArea(
        child: Snap(
          controller: controller.bottomNavigationBar,
          child: ValueListenableBuilder<int>(
              valueListenable: controller.bottomNavigationBar.tabNotifier,
              builder: (context, value, child) {
                print(value);
                if (value == 0) return buildTimeline();
                if (value == 2) return buildPost(context);
                if (value == 3)
                  return SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 0.5,
                                  offset: Offset(2.0, 0.5))
                            ]),
                            height: height / 16,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "  Profile",
                                    style: appName,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.settings),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Scaffold(
                                      backgroundColor: Colors.black,
                                      body: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          // SizedBox(
                                          //   height: 50,
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(
                                                  Icons
                                                      .photo_size_select_actual,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {},
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {},
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceEvenly,
                                          //   children: <Widget>[
                                          //     Container(
                                          //       height: 40,
                                          //       width: 120,
                                          //       decoration: BoxDecoration(
                                          //           borderRadius:
                                          //               BorderRadius.circular(20.0),
                                          //           gradient: gradient),
                                          //       child: Center(
                                          //         child: Text(
                                          //           "Remove Photo",
                                          //           style: TextStyle(
                                          //               fontSize: 15.0,
                                          //               fontWeight: FontWeight.bold,
                                          //               color: Colors.white),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     Container(
                                          //       height: 40,
                                          //       width: 120,
                                          //       decoration: BoxDecoration(
                                          //           borderRadius:
                                          //               BorderRadius.circular(20.0),
                                          //           gradient: gradient),
                                          //       child: Center(
                                          //         child: Text(
                                          //           "From Camera",
                                          //           style: TextStyle(
                                          //               fontWeight: FontWeight.bold,
                                          //               color: Colors.white),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     Container(
                                          //       height: 40,
                                          //       width: 120,
                                          //       decoration: BoxDecoration(
                                          //           borderRadius:
                                          //               BorderRadius.circular(20.0),
                                          //           gradient: gradient),
                                          //       child: Center(
                                          //         child: Text(
                                          //           "From Gallery",
                                          //           style: TextStyle(
                                          //               fontWeight: FontWeight.bold,
                                          //               color: Colors.white),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          SizedBox(
                                            height: 100,
                                          ),
                                          Image.network(
                                            "https://firebasestorage.googleapis.com/v0/b/together-98788.appspot.com/o/images%2F%2B917078808081Raghv?alt=media&token=df6f85bb-7515-414d-9b5c-a9e712dabec0",
                                            fit: BoxFit.contain,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: height / 5,
                                    width: height / 5,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.asset(
                                        "assets/profile.jpg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Following",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("135")
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Followers",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("828")
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Posts",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("92")
                                ],
                              ),
                            ],
                          ),
                          ListTile(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      content: Container(
                                        child: Column(
                                          children: <Widget>[
                                            ListTile(
                                                onTap: () {},
                                                leading: IconButton(
                                                  icon: Icon(
                                                    Icons.person,
                                                    color:
                                                        Colors.lightBlueAccent,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                                // isThreeLine: true,
                                                // isThreeLine: true,
                                                trailing: Icon(Icons.edit),
                                                title: Text(
                                                  "Name",
                                                  style: GoogleFonts.openSans(),
                                                ),
                                                subtitle: Text(
                                                  "Raghav Garg",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Divider(),
                                            ListTile(
                                                onTap: () {},
                                                leading: IconButton(
                                                  icon: Icon(
                                                    Icons.info,
                                                    color:
                                                        Colors.lightBlueAccent,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                                // isThreeLine: true,
                                                trailing: Icon(Icons.edit),
                                                title: Text(
                                                  "About",
                                                  style: GoogleFonts.openSans(),
                                                ),
                                                subtitle: Text(
                                                  "",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Divider(),
                                            ListTile(
                                                onTap: () {},
                                                leading: Icon(
                                                  Icons.phone,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                // onPressed: () {},
                                                // ),
                                                // isThreeLine: true,
                                                trailing: Icon(Icons.edit),
                                                title: Text(
                                                  "Mobile No",
                                                  style: GoogleFonts.openSans(),
                                                ),
                                                subtitle: Text(
                                                  "+919012220988",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Divider(),
                                            ListTile(
                                                onTap: () {},
                                                leading: Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                // onPressed: () {},
                                                // ),
                                                // isThreeLine: true,
                                                trailing: Icon(Icons.edit),
                                                title: Text(
                                                  "DOB",
                                                  style: GoogleFonts.openSans(),
                                                ),
                                                subtitle: Text(
                                                  "06/12/1999",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Divider(),
                                            ListTile(
                                                onTap: () {},
                                                leading: Icon(
                                                  Icons.group_work,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                // onPressed: () {},
                                                // ),
                                                // isThreeLine: true,
                                                trailing: Icon(Icons.edit),
                                                title: Text(
                                                  "Gender",
                                                  style: GoogleFonts.openSans(),
                                                ),
                                                subtitle: Text(
                                                  "Female",
                                                  style: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Divider(),
                                            ListTile(
                                              onTap: () {},
                                              leading: Icon(
                                                Icons.insert_emoticon,
                                                color: Colors.lightBlueAccent,
                                              ),
                                              isThreeLine: true,
                                              // onPressed: () {},
                                              // ),
                                              // isThreeLine: true,
                                              trailing: Icon(Icons.edit),
                                              title: Text(
                                                "Intrests",
                                                style: GoogleFonts.openSans(),
                                              ),
                                              subtitle: Text(
                                                  "Tap here to see Intrestes"),
                                              // subtitle: Text(
                                              //   "Female",
                                              //   style: GoogleFonts.openSans(
                                              //       fontWeight: FontWeight.bold),
                                              // )
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              // leading: IconButton(
                              //   icon: Icon(
                              //     Icons.person,
                              //     color: Colors.lightBlueAccent,
                              //   ),
                              //   onPressed: () {},
                              // ),
                              // isThreeLine: true,
                              // isThreeLine: true,
                              // trailing: Icon(Icons.edit),
                              title: Text(
                                "Raghav Garg",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Tab for more info...",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(),
                              )),
                        ],
                      ),
                    ),
                  );
              }),
        ),
      ),
    );
  }

  Container buildPost(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0.5,
                      offset: Offset(2.0, 0.5))
                ]),
                height: height / 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "  Together",
                        style: appName,
                      ),
                    ),
                    FlatButton(
                      onPressed: post == true ? () {} : null,
                      child: Text(
                        "Post    ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: post == false ? Colors.black : Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: ClipOval(
                            child: Image.asset(
                              "assets/profile.jpg",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "Raghav PAgea",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        content: Container(
                                          height: width / 2,
                                          child: Column(
                                            children: <Widget>[
                                              FlatButton(
                                                child: Text("Everyone"),
                                                onPressed: () {},
                                              ),
                                              FlatButton(
                                                child: Text("Supporters"),
                                                onPressed: () {},
                                              ),
                                              FlatButton(
                                                child:
                                                    Text("Only Share with..."),
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Colors.black)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text("Everyone "),
                                        Icon(Icons.keyboard_arrow_down)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: TextField(
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 1,
                        decoration: InputDecoration(
                            hintText: "   What do you want to share ???",
                            disabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none),
                        onChanged: (value) {
                          print("object");
                          if (value.length == 0)
                            setState(() {
                              post = false;
                            });

                          if (value.length != 0) if (post == false)
                            setState(() {
                              post = true;
                            });
                        },
                        onSubmitted: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.photo_album),
                      Text(
                        "Photo",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.missed_video_call),
                      Text(
                        "Video",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.audiotrack),
                      Text(
                        "Audio",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildTimeline() {
    return Container(
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
